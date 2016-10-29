//
//  FeedViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 12/29/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: TableViewController {
    
    fileprivate let kCellReuse = "PostTableViewCell"
    
    var activity: UIActivityIndicatorView?
    var userNameHidden = false
    
    var viewModel: FeedViewModel? {
        didSet {
            viewModel?.render = { [weak self] in self?.renderViews() }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        styleTableView()
        setupRefreshControl()
        setupTableView()
    }
    
    func renderViews() {
        tableView?.reloadData()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: kCellReuse, bundle: nil), forCellReuseIdentifier: kCellReuse)
    }
    
    func styleTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = Style.lightGrayColor
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.contentInset = UIEdgeInsetsMake(6, 0, 6, 0)
        tableView.estimatedRowHeight = heightForRow()
        tableView.rowHeight = heightForRow()
        tableView.allowsSelection = false
    }
    
    func setupRefreshControl() {
        refreshControl?.tintColor = Style.blueColor
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
    }
    
    func refresh() {
        refreshControl?.endRefreshing()
        tableView.contentInset = UIEdgeInsetsMake(6, 0, 6, 0)
    }
    
    func heightForRow() -> CGFloat {
        return UIScreen.main.bounds.width + 40.0
    }
    
    func cellForRow(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuse, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            viewModel?.postForIndexPath(indexPath, completion: { [weak self] post in
                self?.viewModel?.userForID(post.userID ?? "", completion: { user in
                    guard let strongSelf = self else { return }
                    if !strongSelf.userNameHidden {
                        cell.userButton.setTitle(user.username, for: UIControlState())
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
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserFeedViewController") as? UserFeedViewController {
            vc.user = user
            vc.userNameHidden = true
            navigationController?.show(vc, sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfPosts() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(indexPath) 
    }

}
