//
//  FeedViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 12/29/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit
import RxSwift
import Parse

class FeedViewController: TableViewController {
    
    private let kCellReuse = "PostTableViewCell"
    
    var tableViewDataSource: RxTableViewDataSource!
    var tableViewDelegate: RxTableViewDelegate!
    
    var activity: UIActivityIndicatorView?
    var userNameHidden = false
    
    var viewModel: FeedViewModel? {
        didSet {
            viewModel?.render = { [weak self] in
                self?.renderViews()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl()
    }
    
    func renderViews() {
        tableView?.reloadData()
    }
    
    func setupTableView() {
        tableViewDataSource = RxTableViewDataSource(numberOfRowsInSection: { [weak self] _ in
            return self?.viewModel?.numberOfPosts() ?? 0
        }, cellForRowAtIndexPath: { [weak self] indexPath in
            self?.cellForRow(indexPath) ?? PostTableViewCell()
        })
        
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.registerNib(UINib(nibName: kCellReuse, bundle: nil), forCellReuseIdentifier: kCellReuse)
        styleTableView()
    }
    
    func styleTableView() {
        tableView.separatorStyle = .None
        tableView.backgroundColor = Style.lightGrayColor
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.contentInset = UIEdgeInsetsMake(6, 0, 6, 0)
        tableView.estimatedRowHeight = heightForRow()
        tableView.rowHeight = heightForRow()
        tableView.allowsSelection = false
    }
    
    func setupRefreshControl() {
        refreshControl?.tintColor = Style.blueColor
        refreshControl?.addTarget(self, action: #selector(refresh), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func refresh() {
        refreshControl?.endRefreshing()
        tableView.contentInset = UIEdgeInsetsMake(6, 0, 6, 0)
    }
    
    func heightForRow() -> CGFloat {
        return CGRectGetWidth(UIScreen.mainScreen().bounds) + 40.0
    }
    
    func cellForRow(indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(kCellReuse, forIndexPath: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            viewModel?.postForIndexPath(indexPath, completion: { [weak self] post in
                self?.viewModel?.userForID(post.userID ?? "", completion: { user in
                    guard let strongSelf = self else { return }
                    if !strongSelf.userNameHidden {
                        cell.userButton.setTitle(user.username, forState: .Normal)
                        cell.userButtonTapped = { strongSelf.showPosts(forUser: user) }
                    }
                })
                cell.timeLabel.attributedText = post.timeSinceCreated
                cell.postImageView?.image = post.image
                cell.titleLabel.text = post.title
                cell.subtitleLabel.text = post.subtitle
            })
            return cell
    }
    
    func showPosts(forUser user:PFUser) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FeedViewController") as? FeedViewController {
            vc.viewModel = FeedViewModel(query: FeedQuery.allPosts(forUser: user))
            vc.title = user.username
            vc.userNameHidden = true
            showViewController(vc, sender: self)
        }
    }
    
}
