//
//  Animation.swift
//  Gaggle
//
//  Created by Matthew Bush on 7/10/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import UIKit

class Animation {
    
    class func delay(seconds: Double, completion: @escaping (Void) -> Void) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    class func punchText(_ text: String, label: UILabel, completion: ((Void) -> Void)?) {
        if text.characters.count > 0 {
            label.text = "\(label.text!)\(text.substring(to: text.characters.index(after: text.startIndex)))"
            delay(seconds: 0.16, completion: {
                self.punchText(text.substring(from: text.characters.index(after: text.startIndex)), label: label, completion: completion)
            })
        } else {
            if let completion = completion {
                completion()
            }
        }
    }
    
    class func springAnimation(_ view: UIView, scale: CGFloat, duration: TimeInterval, completion: ((Void) -> Void)?) {
        view.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        UIView.animate(withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 4.0,
            options: UIViewAnimationOptions.allowUserInteraction,
            animations: {
                view.transform = CGAffineTransform.identity
            }, completion: { finished in
                if let completion = completion {
                    completion()
                }
        })
    }
    
    class func fadeIn(_ view: UIView, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: { 
            view.alpha = 1.0
            return
        }) 
    }
    
    class func fadeOut(_ view: UIView, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0.0
            return
        }) 
    }

}
