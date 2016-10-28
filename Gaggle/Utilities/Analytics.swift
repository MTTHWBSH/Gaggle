//
//  Analytics.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/7/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Foundation

class Analytics {
    
    class func logScreen(_ key: String) {
        logGAScreen(key)
    }
    
    class func logEvent(_ category: String, action: String, Label: String, key: String) {
        logGAEvent(category, action: action, label: Label, key: key)
    }
    
    class fileprivate func logGAScreen(_ key: String) {
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: key)
        
        let builder: NSObject = GAIDictionaryBuilder.createScreenView().build()
        tracker.send(builder as? [NSObject : AnyObject])
    }
    
    class fileprivate func logGAEvent(_ category: String, action: String, label: String, key: String) {
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIEventLabel, value: key)
        
        let builder: NSObject = GAIDictionaryBuilder.createEvent(withCategory: category, action: action, label: label, value: 0).build()
        tracker.send(builder as? [NSObject : AnyObject])
    }
    
}
