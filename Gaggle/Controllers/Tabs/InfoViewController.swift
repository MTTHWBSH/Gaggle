//
//  InfoViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 5/16/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

class InfoViewController: TableViewController {
    
    enum Rows: Int {
        case Rate, Terms, Count
    }
    
    private let kCellReuse = "InfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("About")
    }
    
    func setup() {
        title = "Info"
        setupTableView()
        styleTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName: kCellReuse, bundle: nil), forCellReuseIdentifier: kCellReuse)
    }
    
    func styleTableView() {
        tableView.rowHeight = 50
        tableView.separatorStyle = .SingleLine
        tableView.backgroundColor = Style.lightGrayColor
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = Style.lightGrayColor
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.contentInset = UIEdgeInsetsMake(6, 0, 6, 0)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.Count.rawValue
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellForRow(indexPath) ?? InfoTableViewCell()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelectRow(indexPath)
    }
    
    private func cellForRow(indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case Rows.Rate.rawValue:
            setupRateCell(indexPath)
        case Rows.Terms.rawValue:
            setupTermsCell(indexPath)
        default: ()
        }
        return UITableViewCell()
    }
    
    private func didSelectRow(indexPath: NSIndexPath) {
        switch indexPath.row {
        case Rows.Rate.rawValue:
            showRate()
        case Rows.Terms.rawValue:
            showTerms()
        default: ()
        }
    }
    
    private func setupRateCell(indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(kCellReuse, forIndexPath: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = "Rate in App Store"
        cell.subtitleLabel.text = versionNumber()
        return cell
    }
    
    private func setupTermsCell(indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(kCellReuse, forIndexPath: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = "Terms of Service"
        cell.subtitleLabel.text = ""
        return cell
    }
    
    private func versionNumber() -> String? {
        guard let dict = NSBundle.mainBundle().infoDictionary, version = dict["CFBundleShortVersionString"] else { return nil }
        return "v\(version)"
    }
    
    private func showRate() {
        UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/1112225433")!);
    }
    
    private func showTerms() {
        if let nc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("TermsNavigationController") as? NavigationController {
            navigationController?.presentViewController(nc, animated: true, completion: nil)
        }
    }

}
