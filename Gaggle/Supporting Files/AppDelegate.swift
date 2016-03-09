//
//  AppDelegate.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/6/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.enableLocalDatastore()
        
        let config = ParseClientConfiguration(block: {
            (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = parseAppID
            ParseMutableClientConfiguration.clientKey = parseClientKey
            ParseMutableClientConfiguration.server = parseServerURL
        })
        
        let configDev = ParseClientConfiguration(block: {
            (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = parseDevAppID
            ParseMutableClientConfiguration.clientKey = parseDevClientKey
            ParseMutableClientConfiguration.server = parseDevServerURL
        })
        
        if let environment = NSBundle.mainBundle().infoDictionary?["Environment"] as? String {
            switch environment {
            case "Production":
                Parse.initializeWithConfiguration(config)
            case "Dev":
                Parse.initializeWithConfiguration(configDev)
            default:
                break
            }
        }
        
        if !Session.currentSession.loggedIn() {
            let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("Intro") as! IntroViewController
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        } else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main") as! TabBarController
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
        
        SVProgressHUD.setFont(Style.regularFontWithSize(14.0))
        
        return true
    }

}
