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
import ReachabilitySwift

class Configuration {
    
    class func setupServices(_ launchOptions: [AnyHashable: Any]?) {

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

        if let environment = Bundle.main.infoDictionary?["Environment"] as? String {
            switch environment {
            case "Production":
                Parse.initialize(with: config)
                Instabug.start(withToken: instabugToken, invocationEvent: .none)
            case "Dev":
                Parse.initialize(with: configDev)
                Instabug.start(withToken: instabugDevToken, invocationEvent: .none)
            default:
                break
            }
        }
        
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        SVProgressHUD.setFont(Style.regularFontWithSize(14.0))
        SVProgressHUD.setDefaultMaskType(.black)
    }
    
    class func run(_ window: UIWindow?) {
        
        let reachability = Reachability()
        reachability?.whenUnreachable = { _ in SVProgressHUD.showError(withStatus: "Unable to connect to internet. Please check your connection and try again.") }
        do { try reachability?.startNotifier() } catch { print("Unable to start reachability notifier") }
        
        func showLogin() {
            if let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewController(withIdentifier: "Intro") as? IntroViewController {
                window?.rootViewController = vc
                window?.makeKeyAndVisible()
            }
        }
        
        func showFeed() {
            if let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as? TabBarController {
                window?.rootViewController = nc
                window?.makeKeyAndVisible()
            }
        }
        
        if !Session.currentSession.loggedIn() {
            showLogin()
        } else {
            showFeed()
        }
    }
    
}
