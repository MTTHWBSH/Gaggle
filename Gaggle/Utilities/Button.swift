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
        
        setBackgroundImage(colorImage, forState: forState)
    }
}


class Button: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style() {
        titleLabel?.font = Style.regularFontWithSize(14.0)
        setBackgroundColor(UIColor.clearColor(), forState: .Normal)
        setBackgroundColor(UIColor.clearColor(), forState: .Selected)
        setBackgroundColor(UIColor.clearColor(), forState: .Highlighted)
        setBackgroundColor(UIColor.clearColor(), forState: .Disabled)
        setTitleColor(Style.orangeColor, forState: .Normal)
        setTitleColor(Style.orangeColorSelected, forState: .Selected)
        setTitleColor(Style.orangeColorSelected, forState: .Highlighted)
        setTitleColor(Style.orangeColor.colorWithAlphaComponent(0.8), forState: .Disabled)
        adjustsImageWhenDisabled = false
        adjustsImageWhenHighlighted = false
    }
    
}

class SecondaryTextButton: Button {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    override func style() {
        setTitleColor(Style.blueColor, forState: .Normal)
        setTitleColor(Style.blueColorSelected, forState: .Selected)
        setTitleColor(Style.blueColorSelected, forState: .Highlighted)
        setTitleColor(Style.blueColor.colorWithAlphaComponent(0.8), forState: .Disabled)
    }
    
}

class PrimaryButton: Button {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    override func style() {
        titleLabel?.font = Style.regularFontWithSize(18.0)
        setBackgroundColor(Style.blueColor, forState: .Normal)
        setBackgroundColor(Style.blueColorSelected, forState: .Selected)
        setBackgroundColor(Style.blueColorSelected, forState: .Highlighted)
        setBackgroundColor(Style.blueColor.colorWithAlphaComponent(0.8), forState: .Disabled)
        setTitleColor(Style.whiteColor, forState: .Normal)
        setTitleColor(Style.whiteColorSelected, forState: .Selected)
        setTitleColor(Style.whiteColorSelected, forState: .Highlighted)
        setTitleColor(Style.whiteColor.colorWithAlphaComponent(0.8), forState: .Disabled)
    }
    
}

class SecondaryButton: Button {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    override func style() {
        titleLabel?.font = Style.regularFontWithSize(18.0)
        setBackgroundColor(Style.blackColor, forState: .Normal)
        setBackgroundColor(Style.blackColorSelected, forState: .Selected)
        setBackgroundColor(Style.blackColorSelected, forState: .Highlighted)
        setBackgroundColor(Style.blackColor.colorWithAlphaComponent(0.8), forState: .Disabled)
        setTitleColor(Style.whiteColor, forState: .Normal)
        setTitleColor(Style.whiteColorSelected, forState: .Selected)
        setTitleColor(Style.whiteColorSelected, forState: .Highlighted)
        setTitleColor(Style.whiteColor.colorWithAlphaComponent(0.8), forState: .Disabled)
    }
    
}
