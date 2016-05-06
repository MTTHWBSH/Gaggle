//
//  FeedViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 12/29/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit
import RxSwift

class FeedViewController: UITableViewController {
    
    private let kCellReuse = "PostTableViewCell"
    
    var tableViewDataSource: RxTableViewDataSource!
    var tableViewDelegate: RxTableViewDelegate!
    
    var viewModel: FeedViewModel? {
        didSet {
            viewModel?.render = { [weak self] in
                self?.renderViews()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gaggle"
        setupTableView()
        renderViews()
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
    
    func heightForRow() -> CGFloat {
        return CGRectGetWidth(UIScreen.mainScreen().bounds) + 40.0
    }
    
    func cellForRow(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellReuse, forIndexPath: indexPath) as! PostTableViewCell
        viewModel?.postForIndexPath(indexPath, completion: { [weak self] post in
            self?.viewModel?.userForID(post.userID ?? "", completion: { user in
                cell.user = user
                cell.userButton.setTitle(user.username, forState: .Normal)
            })
            cell.timeLabel.attributedText = post.timeSinceCreated
            cell.postImageView?.image = post.image
        })
        return cell
    }
    
}
