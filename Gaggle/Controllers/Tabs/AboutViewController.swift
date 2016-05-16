//
//  AboutViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 5/16/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

class AboutViewController: TableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("About")
    }
    
    func setup() {
        title = "About"
        //        if let dict = NSBundle.mainBundle().infoDictionary {
        //            if let version = dict["CFBundleShortVersionString"] {
        //                versionLabel.text = "v\(version)"
        //            } else {
        //                versionLabel.text = ""
        //            }
        //        } else {
        //            versionLabel.text = ""
        //        }
        //
        //        versionLabel.font = Style.regularFontWithSize(22.0)
        //        versionLabel.textColor = Style.blackColor
    }

}
