//
//  InfoViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 5/16/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

class InfoViewController: TableViewController {
    
    private let kCellReuse = "PostTableViewCell"
    
    var tableViewDataSource: RxTableViewDataSource!
    var tableViewDelegate: RxTableViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("About")
    }
    
    func setup() {
        title = "About"
        //        if let dict = NSBundle.mainBundle().infoDictionary {
        //            if let version = dict["CFBundleShortVersionString"] {
        //                versionLabel.text = "v\(version)"
        //            } else {
        //                versionLabel.text = ""
        //            }
        //        } else {
        //            versionLabel.text = ""
        //        }
        //
        //        versionLabel.font = Style.regularFontWithSize(22.0)
        //        versionLabel.textColor = Style.blackColor
    }
    
    func setupTableView() {
        tableViewDataSource = RxTableViewDataSource(numberOfRowsInSection: { _ in
            return 1
            }, cellForRowAtIndexPath: { [weak self] indexPath in
                return UITableViewCell()
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
    }

}
