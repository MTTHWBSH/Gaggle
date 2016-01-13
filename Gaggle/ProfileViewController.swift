//
//  ProfileViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/4/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

class ProfileViewController: ViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {  
        if Session.currentSession.loggedIn()  {
            guard let user = PFUser.currentUser() else { return }
            navigationItem.title = user.username
            // hide empty state
        } else {
            navigationItem.title = "Profile"
            // show empty state
        }
    }
    
    @IBAction func settingsButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("ToSettings", sender: self)
    }
    
}
