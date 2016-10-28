//
//  InfoViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 5/16/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

enum Rows: Int {
    case rate, terms, report, feedback, count
}

extension Rows {
    var title: String {
        switch self{
        case .rate: return "Rate in App Store"
        case .terms: return "Terms of Service"
        case .report: return "Report an Issue"
        case .feedback: return "Submit Feedback"
        default: return ""
        }
    }
    
    var subtitle: String {
        switch self{
        case .rate: return InfoViewController.versionNumber() ?? ""
        default: return ""
        }
    }
}

class InfoViewController: TableViewController {
    
    fileprivate let kCellReuse = "InfoTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        tableView.register(UINib(nibName: kCellReuse, bundle: nil), forCellReuseIdentifier: kCellReuse)
    }
    
    func styleTableView() {
        tableView.rowHeight = 50
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = Style.lightGrayColor
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = Style.lightGrayColor
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.contentInset = UIEdgeInsetsMake(1, 0, 1, 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.count.rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        didSelectRow(indexPath)
    }
    
    fileprivate func cellForRow(_ indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case Rows.rate.rawValue:
            return setupCell(indexPath, row: .rate)
        case Rows.terms.rawValue:
            return setupCell(indexPath, row: .terms)
        case Rows.report.rawValue:
            return setupCell(indexPath, row: .report)
        case Rows.feedback.rawValue:
            return setupCell(indexPath, row: .feedback)
        default: return UITableViewCell()
        }
    }
    
    fileprivate func didSelectRow(_ indexPath: IndexPath) {
        switch indexPath.row {
        case Rows.rate.rawValue:
            showRate()
        case Rows.terms.rawValue:
            showTerms()
        case Rows.report.rawValue:
            reportIssue()
        case Rows.feedback.rawValue:
            sendFeedback()
        default: ()
        }
    }
    
    fileprivate func setupCell(_ indexPath: IndexPath, row: Rows) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuse, for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
        cell.primaryLabel.text = row.title
        cell.secondaryLabel.text = row.subtitle
        return cell
    }
    
    class func versionNumber() -> String? {
        guard let dict = Bundle.main.infoDictionary, let version = dict["CFBundleShortVersionString"] else { return nil }
        return "v\(version)"
    }
    
    fileprivate func showRate() {
        UIApplication.shared.openURL(URL(string : "itms-apps://itunes.apple.com/app/id1112225433?mt=8&uo=4")!);
    }
    
    fileprivate func showTerms() {
        guard let nc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewController(withIdentifier: "TermsNavigationController") as? NavigationController,
                  let vc = nc.topViewController as? TermsViewController else { return }
        vc.fromSettings = true
        navigationController?.present(nc, animated: true, completion: nil)
    }
    
    fileprivate func reportIssue() {
        Instabug.invoke(with: .newBug)
    }
    
    fileprivate func sendFeedback() {
        Instabug.invoke(with: .newFeedback)
    }

}
