//
//  Button.swift
//  Gaggle
//
//  Created by Matthew Bush on 9/28/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit
import Foundation

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor)
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, forState: forState)
    }
}


class Button: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        setBackgroundColor(UIColor.clearColor(), forState: .Normal)
        setBackgroundColor(UIColor.clearColor(), forState: .Selected)
        setBackgroundColor(UIColor.clearColor(), forState: .Highlighted)
        setBackgroundColor(UIColor.clearColor(), forState: .Disabled)
        setTitleColor(Style.redColor, forState: .Normal)
        setTitleColor(Style.redColorSelected, forState: .Selected)
        setTitleColor(Style.redColorSelected, forState: .Highlighted)
        setTitleColor(Style.redColorSelected, forState: .Disabled)
        adjustsImageWhenDisabled = false
        adjustsImageWhenHighlighted = false
    }
    
}

class PrimaryButton: Button {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    override func style() {
        Style.boldFontWithSize(18.0)
        setBackgroundColor(Style.redColor, forState: .Normal)
        setBackgroundColor(Style.redColorSelected, forState: .Selected)
        setBackgroundColor(Style.redColorSelected, forState: .Highlighted)
        setBackgroundColor(Style.redColorSelected, forState: .Disabled)
        setTitleColor(Style.whiteColor, forState: .Normal)
        setTitleColor(Style.whiteColorSelected, forState: .Selected)
        setTitleColor(Style.whiteColorSelected, forState: .Highlighted)
        setTitleColor(Style.whiteColorSelected, forState: .Disabled)
    }
    
}

class SecondaryButton: Button {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    override func style() {
        Style.boldFontWithSize(18.0)
        setBackgroundColor(Style.grayColor, forState: .Normal)
        setBackgroundColor(Style.grayColorSelected, forState: .Selected)
        setBackgroundColor(Style.grayColorSelected, forState: .Highlighted)
        setBackgroundColor(Style.grayColorSelected, forState: .Disabled)
        setTitleColor(Style.whiteColor, forState: .Normal)
        setTitleColor(Style.whiteColorSelected, forState: .Selected)
        setTitleColor(Style.whiteColorSelected, forState: .Highlighted)
        setTitleColor(Style.whiteColorSelected, forState: .Disabled)
    }
    
}
