//
//  Animation.swift
//  Gaggle
//
//  Created by Matthew Bush on 7/10/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import Foundation

class Animation {
    
    class func delay(seconds seconds: Double, completion: Void -> Void) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    class func punchText(text: String, label: UILabel, completion: (Void -> Void)?) {
        if text.characters.count > 0 {
            label.text = "\(label.text!)\(text.substringToIndex(text.startIndex.successor()))"
            delay(seconds: 0.16, completion: {
                self.punchText(text.substringFromIndex(text.startIndex.successor()), label: label, completion: completion)
            })
        } else {
            if let completion = completion {
                completion()
            }
        }
    }
    
    class func springAnimation(view: UIView) {
        view.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        UIView.animateWithDuration(1.7,
            delay: 0,
            usingSpringWithDamping: 0.40,
            initialSpringVelocity: 6.00,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                view.transform = CGAffineTransformIdentity
            }, completion: nil)
    }

}
