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
            let rightBarButtonItem = BarButtonItem(image: UIImage(named: "Gear"), style: .Plain, target: self, action: "settingsButtonPressed")
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
