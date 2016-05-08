//
//  AppDelegate.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/6/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Configuration.setupServices(launchOptions)
        
        func showLogin() {
            if let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("Intro") as? IntroViewController {
                window?.rootViewController = vc
                window?.makeKeyAndVisible()
            }
        }
        
        func showFeed() {
            if let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main") as? TabBarController {
                window?.rootViewController = nc
                window?.makeKeyAndVisible()
            }
        }
        
        if !Session.currentSession.loggedIn() {
            showLogin()
        } else {
            showFeed()
        }
        
        return true
    }

}
