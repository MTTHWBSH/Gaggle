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
    
    func style() {
        titleLabel?.font = Style.regularFontWithSize(14.0)
        setBackgroundColor(UIColor.clearColor(), forState: .Normal)
        setBackgroundColor(UIColor.clearColor(), forState: .Selected)
        setBackgroundColor(UIColor.clearColor(), forState: .Highlighted)
        setBackgroundColor(UIColor.clearColor(), forState: .Disabled)
        setTitleColor(Style.orangeColor, forState: .Normal)
        setTitleColor(Style.orangeColorSelected, forState: .Selected)
        setTitleColor(Style.orangeColorSelected, forState: .Highlighted)
        setTitleColor(Style.orangeColorSelected, forState: .Disabled)
        adjustsImageWhenDisabled = false
        adjustsImageWhenHighlighted = false
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
        setBackgroundColor(Style.orangeColorSelected, forState: .Selected)
        setBackgroundColor(Style.orangeColorSelected, forState: .Highlighted)
        setBackgroundColor(Style.orangeColorSelected, forState: .Disabled)
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
        setBackgroundColor(Style.grayColorSelected, forState: .Selected)
        setBackgroundColor(Style.grayColorSelected, forState: .Highlighted)
        setBackgroundColor(Style.grayColorSelected, forState: .Disabled)
        setTitleColor(Style.whiteColor, forState: .Normal)
        setTitleColor(Style.whiteColorSelected, forState: .Selected)
        setTitleColor(Style.whiteColorSelected, forState: .Highlighted)
        setTitleColor(Style.whiteColorSelected, forState: .Disabled)
    }
    
}
