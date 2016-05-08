//
//  Analytics.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/7/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Foundation

class Analytics {
    
    class func logScreen(key: String) {
        logGAScreen(key)
    }
    
    class func logEvent(category: String, action: String, Label: String, key: String) {
        logGAEvent(category, action: action, label: Label, key: key)
    }
    
    class private func logGAScreen(key: String) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: key)
        
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    class private func logGAEvent(category: String, action: String, label: String, key: String) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIEventLabel, value: key)
        
        let builder = GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: 0)
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
}