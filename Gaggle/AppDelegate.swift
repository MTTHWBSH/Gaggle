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
        // Override point for customization after application launch.
        
        Parse.enableLocalDatastore()
        
        if let environment = NSBundle.mainBundle().infoDictionary?["Environment"] as? String {
            switch environment {
            case "Production":
                Parse.setApplicationId(parseDevAppID, clientKey: parseDevClientKey)
            case "Dev":
                Parse.setApplicationId(parseDevAppID, clientKey: parseDevClientKey)
            default:
                break
            }
        }
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        return true
    }

}
