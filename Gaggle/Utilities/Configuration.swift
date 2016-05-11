//
//  Configuration.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/7/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class Configuration {
    
    class func setupServices(launchOptions: [NSObject: AnyObject]?) {

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
                Instabug.startWithToken(instabugToken, invocationEvent: .None)
            case "Dev":
                Parse.initializeWithConfiguration(configDev)
                Instabug.startWithToken(instabugDevToken, invocationEvent: .None)
            default:
                break
            }
        }
        
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        SVProgressHUD.setFont(Style.regularFontWithSize(14.0))
        SVProgressHUD.setDefaultMaskType(.Black)
    }
    
    class func run(window: UIWindow?) {
        
        func showLogin() {
            if let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("Intro") as? IntroViewController {
                window?.rootViewController = vc
                window?.makeKeyAndVisible()
                Reachability.tryReachability(vc)
            }
        }
        
        func showFeed() {
            if let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main") as? TabBarController {
                window?.rootViewController = nc
                window?.makeKeyAndVisible()
                Reachability.tryReachability(nc)
            }
        }
        
        if !Session.currentSession.loggedIn() {
            showLogin()
        } else {
            showFeed()
        }
    }
    
}
