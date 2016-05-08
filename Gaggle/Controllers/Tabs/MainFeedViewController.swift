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
        viewModel = FeedViewModel(query: FeedQuery.allPosts())
    }

}
