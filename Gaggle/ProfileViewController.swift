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
        if let user = PFUser.currentUser() {
            navigationItem.title = user.username
        } else {
            navigationItem.title = "Profile"
        }
    }
    
    @IBAction func settingsButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("ToSettings", sender: self)
    }
    
}
