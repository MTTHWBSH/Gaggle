//
//  MainFeedViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/7/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Parse

class MainFeedViewController: FeedViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gaggle"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Home Feed")
    }
    
    override func refresh() {
        setup()
        super.refresh()
    }
    
    func setup() {
        let hasShownTerms = NSUserDefaults.standardUserDefaults().boolForKey(Constants.HasShownTerms)
        hasShownTerms ? viewModel = FeedViewModel(query: FeedQuery.allPosts()) : showTerms()
    }
    
    private func showTerms() {
        guard let nc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("TermsNavigationController") as? NavigationController,
            vc = nc.topViewController as? TermsViewController else { return }
        vc.fromSettings = false
        navigationController?.presentViewController(nc, animated: true, completion: nil)
    }
    
}
