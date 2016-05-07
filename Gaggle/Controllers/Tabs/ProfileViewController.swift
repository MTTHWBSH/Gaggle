//
//  ProfileViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/4/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Parse

class ProfileViewController: FeedViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    func setup() {
        userNameHidden = true
        if Session.currentSession.loggedIn()  {
            guard let user = PFUser.currentUser() else { return }
            navigationItem.title = user.username
            viewModel = FeedViewModel(query: FeedQuery.allPosts(forUser: user))
            let rightBarButtonItem = BarButtonItem(image: UIImage(named: "Gear"), style: .Plain, target: self, action: #selector(settingsButtonPressed))
            navigationItem.rightBarButtonItem = rightBarButtonItem
        } else {
            navigationItem.title = "Profile"
            navigationItem.rightBarButtonItem = nil
            
        }
    }
    
    func settingsButtonPressed() {
        performSegueWithIdentifier("ToSettings", sender: self)
    }
    
}
