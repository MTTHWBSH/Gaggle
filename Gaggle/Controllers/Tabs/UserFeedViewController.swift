//
//  UserFeedViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 5/24/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Parse
import PureLayout

class UserFeedViewController: FeedViewController {
    
    var user: PFUser?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("User Feed")
    }
    
    override func refresh() {
        setup()
        super.refresh()
    }
    
    func setup() {
        guard let user = user else { return }
        setupActivityIndicator()
        navigationItem.title = user.username
        viewModel = FeedViewModel(query: FeedQuery.allPosts(forUser: user))
        viewModel?.queryComplete = { [weak self] void in self?.removeActivityIndicator() }
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
    
}
