//
//  FeedViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 12/29/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Parse

class FeedViewController: TableViewController {
    
    fileprivate let kCellReuse = "PostTableViewCell"
    
    let disposeBag = DisposeBag()
    
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
        guard let tableView = tableView else { return }
        tableView.register(UINib(nibName: kCellReuse, bundle: nil), forCellReuseIdentifier: kCellReuse)
        Observable
            .just(viewModel?.posts)
            .bindTo(tableView
            .rx
            .items(cellIdentifier: kCellReuse, cellType: PostTableViewCell.self)) {
                    
            }
        .addDisposableTo(disposeBag)
        
//        tableViewDataSource = RxTableViewDataSource(numberOfRowsInSection: { [weak self] _ in
//            return self?.viewModel?.numberOfPosts() ?? 0
//        }, cellForRowAtIndexPath: { [weak self] indexPath in
//            self?.cellForRow(indexPath as IndexPath) ?? PostTableViewCell()
//        })
        
        styleTableView()
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
    
}
