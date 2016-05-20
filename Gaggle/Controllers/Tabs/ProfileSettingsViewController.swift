//
//  ProfileSettingsViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class ProfileSettingsViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Profile Settings")
    }
    
    func setup() {
        guard let user = PFUser.currentUser() else { return }
        navigationItem.title = user.username
    }
    
    func signOut() {
        Analytics.logEvent("Profile", action: "Sign Out", Label: "Sign Out Button Pressed", key: "")
        SVProgressHUD.showWithStatus("Signing out")
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            SVProgressHUD.dismiss()
            guard let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("Intro") as? IntroViewController else { return }
            self.presentViewController(vc, animated: true, completion: nil)
        })
    }
    
    func showInfo() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("InfoViewController") as? InfoViewController {
            showViewController(vc, sender: self)
        }
    }
    
    @IBAction func aboutPressed(sender: AnyObject) {
        showInfo()
    }

    @IBAction func signOutPressed(sender: AnyObject) {
        signOut()
    }
    
}
