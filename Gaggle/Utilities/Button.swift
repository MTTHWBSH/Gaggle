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
    func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        setBackgroundImage(colorImage, for: forState)
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
        setBackgroundColor(UIColor.clear, forState: UIControlState())
        setBackgroundColor(UIColor.clear, forState: .selected)
        setBackgroundColor(UIColor.clear, forState: .highlighted)
        setBackgroundColor(UIColor.clear, forState: .disabled)
        setTitleColor(Style.orangeColor, for: UIControlState())
        setTitleColor(Style.orangeColorSelected, for: .selected)
        setTitleColor(Style.orangeColorSelected, for: .highlighted)
        setTitleColor(Style.orangeColor.withAlphaComponent(0.8), for: .disabled)
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
        setTitleColor(Style.blueColor, for: UIControlState())
        setTitleColor(Style.blueColorSelected, for: .selected)
        setTitleColor(Style.blueColorSelected, for: .highlighted)
        setTitleColor(Style.blueColor.withAlphaComponent(0.8), for: .disabled)
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
        setBackgroundColor(Style.blueColor, forState: UIControlState())
        setBackgroundColor(Style.blueColorSelected, forState: .selected)
        setBackgroundColor(Style.blueColorSelected, forState: .highlighted)
        setBackgroundColor(Style.blueColor.withAlphaComponent(0.8), forState: .disabled)
        setTitleColor(Style.whiteColor, for: UIControlState())
        setTitleColor(Style.whiteColorSelected, for: .selected)
        setTitleColor(Style.whiteColorSelected, for: .highlighted)
        setTitleColor(Style.whiteColor.withAlphaComponent(0.8), for: .disabled)
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
        setBackgroundColor(Style.blackColor, forState: UIControlState())
        setBackgroundColor(Style.blackColorSelected, forState: .selected)
        setBackgroundColor(Style.blackColorSelected, forState: .highlighted)
        setBackgroundColor(Style.blackColor.withAlphaComponent(0.8), forState: .disabled)
        setTitleColor(Style.whiteColor, for: UIControlState())
        setTitleColor(Style.whiteColorSelected, for: .selected)
        setTitleColor(Style.whiteColorSelected, for: .highlighted)
        setTitleColor(Style.whiteColor.withAlphaComponent(0.8), for: .disabled)
    }
    
}
