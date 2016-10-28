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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Profile Settings")
    }
    
    func setup() {
        guard let user = PFUser.current() else { return }
        navigationItem.title = user.username
    }
    
    func signOut() {
        Analytics.logEvent("Profile", action: "Sign Out", Label: "Sign Out Button Pressed", key: "")
        SVProgressHUD.show(withStatus: "Signing out")
        PFUser.logOut()
        
        DispatchQueue.main.async(execute: { () -> Void in
            SVProgressHUD.dismiss()
            guard let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewController(withIdentifier: "Intro") as? IntroViewController else { return }
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    func showInfo() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController {
            show(vc, sender: self)
        }
    }
    
    @IBAction func aboutPressed(_ sender: AnyObject) {
        showInfo()
    }

    @IBAction func signOutPressed(_ sender: AnyObject) {
        signOut()
    }
    
}
