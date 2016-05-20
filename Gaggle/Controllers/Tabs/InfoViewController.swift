//
//  InfoViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 5/16/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

enum Rows: Int {
    case Rate, Terms, Report, Feedback, Count
}

extension Rows {
    var title: String {
        switch self{
        case Rate: return "Rate in App Store"
        case Terms: return "Terms of Service"
        case Report: return "Report an Issue"
        case Feedback: return "Submit Feedback"
        default: return ""
        }
    }
    
    var subtitle: String {
        switch self{
        case Rate: return InfoViewController.versionNumber() ?? ""
        default: return ""
        }
    }
}

class InfoViewController: TableViewController {
    
    private let kCellReuse = "InfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Info")
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
        tableView.contentInset = UIEdgeInsetsMake(1, 0, 1, 0)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.Count.rawValue
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellForRow(indexPath) ?? InfoTableViewCell()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        didSelectRow(indexPath)
    }
    
    private func cellForRow(indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case Rows.Rate.rawValue:
            setupCell(indexPath, row: .Rate)
        case Rows.Terms.rawValue:
            setupCell(indexPath, row: .Terms)
        case Rows.Report.rawValue:
            setupCell(indexPath, row: .Report)
        case Rows.Feedback.rawValue:
            setupCell(indexPath, row: .Feedback)
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
        case Rows.Report.rawValue:
            reportIssue()
        case Rows.Feedback.rawValue:
            sendFeedback()
        default: ()
        }
    }
    
    private func setupCell(indexPath: NSIndexPath, row: Rows) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(kCellReuse, forIndexPath: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = row.title
        cell.subtitleLabel.text = row.subtitle
        return cell
    }
    
    class func versionNumber() -> String? {
        guard let dict = NSBundle.mainBundle().infoDictionary, version = dict["CFBundleShortVersionString"] else { return nil }
        return "v\(version)"
    }
    
    private func showRate() {
        UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/1112225433")!);
    }
    
    private func showTerms() {
        guard let nc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("TermsNavigationController") as? NavigationController,
                  vc = nc.topViewController as? TermsViewController else { return }
        vc.fromSettings = true
        navigationController?.presentViewController(nc, animated: true, completion: nil)
    }
    
    private func reportIssue() {
        Instabug.invokeWithInvocationMode(.BugReporter)
    }
    
    private func sendFeedback() {
        Instabug.invokeWithInvocationMode(.FeedbackSender)
    }

}
