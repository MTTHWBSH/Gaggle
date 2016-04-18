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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        renderViews()
    }
    
    func renderViews() {
        tableView?.reloadData()
    }
    
    func setupTableView() {
        tableViewDataSource = RxTableViewDataSource(numberOfRowsInSection: { [weak self] _ in
            return self?.viewModel?.numberOfPosts() ?? 0
            }, cellForRowAtIndexPath: { [weak self] indexPath in
                return self?.cellForRow(indexPath) ?? UITableViewCell()
            })
        
        tableView.registerNib(UINib(nibName: kCellReuse, bundle: nil), forCellReuseIdentifier: kCellReuse)
        tableView.separatorStyle = .None
        tableView.backgroundColor = Style.lightGrayColor
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
    }
    
    // MARK:- UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfPosts() ?? 0
    }
    
    // MARK:- UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForRow()
    }
    
    // MARK:- UITableViewHelpers
    
    func heightForRow() -> CGFloat {
        return 360.0
    }
    
    func cellForRow(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellReuse, forIndexPath: indexPath)
        return cell
    }
    
}
