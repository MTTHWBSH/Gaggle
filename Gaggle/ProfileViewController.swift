//
//  ProfileViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class ProfileViewController: ViewController {
    
    @IBOutlet var versionLabel: Label!
    
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
        
        if let dict = NSBundle.mainBundle().infoDictionary {
            if let version = dict["CFBundleShortVersionString"] {
                versionLabel.text = "v\(version)"
            } else {
                versionLabel.text = ""
            }
        } else {
            versionLabel.text = ""
        }
    }
    
    @IBAction func SignOut(sender: PrimaryButton) {
        SVProgressHUD.showWithStatus("Signing out", maskType: .Black)
        PFUser.logOut()
        SVProgressHUD.dismiss()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("Intro") as! IntroViewController
            self.presentViewController(vc, animated: true, completion: nil)
        })
    }
}
