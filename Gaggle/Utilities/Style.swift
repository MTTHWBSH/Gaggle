//
//  Style.swift
//  Gaggle
//
//  Created by Matthew Bush on 7/10/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import Foundation

class Style {
    
    // MARK: Constants
    
    private struct Constants {
        static let kRegularFontName = "Lato-Regular"
        static let kLightFontName = "Lato-Light"
        static let kHairlineFontName = "Lato-Hairline"
        static let kBoldFontName = "Lato-Bold"
    }
    
    // MARK: Fonts
    
    class func regularFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: Constants.kRegularFontName, size: size)!
    }
    
    class func lightFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: Constants.kLightFontName, size: size)!
    }
    
    class func hairlineFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: Constants.kHairlineFontName, size: size)!
    }
    
    class func boldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: Constants.kBoldFontName, size: size)!
    }
    
    // MARK: Colors
    
    static let whiteColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let whiteColorSelected = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8)
    static let lightGrayColor = UIColor(red: 242.0, green: 242.0, blue: 242.0, alpha: 1.0)
    static let grayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1.0)
    static let grayColorSelected = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 0.8)
    static let blackColor = UIColor(red: 5.0/255.0, green: 5.0/255.0, blue: 5.0/255.0, alpha: 1.0)
    static let redColor = UIColor(red: 225.0/255.0, green: 56.0/255.0, blue: 47.0/255.0, alpha: 1.0)
    static let redColorSelected = UIColor(red: 225.0/255.0, green: 56.0/255.0, blue: 47.0/255.0, alpha: 0.8)
    
    // MARK: Borders
    
    class func addBottomBorder(toLayer layer: CALayer, onFrame frame: CGRect) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = self.grayColor.CGColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: frame.size.height)
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
}
