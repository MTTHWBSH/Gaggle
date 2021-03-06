//
//  MainFeedViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/7/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Parse
import PureLayout

class MainFeedViewController: FeedViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationItem.title = "Gaggle"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Home Feed")
    }
    
    override func refresh() {
        setup()
        super.refresh()
    }
    
    func setup() {
        let hasShownTerms = UserDefaults.standard.bool(forKey: Constants.HasShownTerms)
        if hasShownTerms {
            setupActivityIndicator()
            viewModel = FeedViewModel(query: FeedQuery.allPosts())
            viewModel?.queryComplete = { [weak self] void in self?.removeActivityIndicator() }
        } else {
           showTerms()
        }
    }
    
    func setupActivityIndicator() {
        activity = UIActivityIndicatorView()
        activity?.color = Style.blueColor
        activity?.startAnimating()
        if let activity = activity {
            view.addSubview(activity)
            activity.autoCenterInSuperview()
        }
    }
    
    func removeActivityIndicator() {
        activity?.removeFromSuperview()
    }
    
    fileprivate func showTerms() {
        guard let nc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewController(withIdentifier: "TermsNavigationController") as? NavigationController,
            let vc = nc.topViewController as? TermsViewController else { return }
        vc.fromSettings = false
        vc.agreePressed = { [weak self] void in self?.setup() }
        navigationController?.present(nc, animated: true, completion: nil)
    }
    
}
