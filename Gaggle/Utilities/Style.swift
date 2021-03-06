//
//  Style.swift
//  Gaggle
//
//  Created by Matthew Bush on 7/10/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import UIKit

class Style {
    
    // MARK: Constants
    
    fileprivate struct Constants {
        static let kRegularFontName = "Lato-Regular"
        static let kLightFontName = "Lato-Light"
        static let kHairlineFontName = "Lato-Hairline"
        static let kBoldFontName = "Lato-Bold"
        static let kBrandFontName = "JosefinSans-Bold"
    }
    
    // MARK: Fonts
    
    class func regularFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: Constants.kRegularFontName, size: size)!
    }
    
    class func lightFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: Constants.kLightFontName, size: size)!
    }
    
    class func hairlineFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: Constants.kHairlineFontName, size: size)!
    }
    
    class func boldFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: Constants.kBoldFontName, size: size)!
    }
    
    class func brandFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: Constants.kBrandFontName, size: size)!
    }
    
    // MARK: Colors
    
    static let whiteColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let whiteColorSelected = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    
    static let lightGrayColor = UIColor(red: 236.0/255.0, green: 233.0/255.0, blue: 231.0/255.0, alpha: 1.0)
    
    static let grayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1.0)
    static let grayColorSelected = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 0.8)
    
    static let blackColor = UIColor(red: 76.0/255.0, green: 76.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    static let blackColorSelected = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)

    static let blueColor = UIColor(red: 97.0/255.0, green: 191.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    static let blueColorSelected = UIColor(red: 72.0/255.0, green: 166.0/255.0, blue: 177.0/255.0, alpha: 1.0)

    static let orangeColor = UIColor(red: 211.0/255.0, green: 135.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    static let orangeColorSelected = UIColor(red: 186.0/255.0, green: 110.0/255.0, blue: 35.0/255.0, alpha: 1.0)
    
    static let greenColor = UIColor(red: 52.0/255.0, green: 105.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    static let yellowColor = UIColor(red: 204.0/255.0, green: 165.0/255.0, blue: 44.0/255.0, alpha: 1.0)
    
    class func randomBrandColor(withOpacity opacity:CGFloat) -> UIColor {
        let colors = [blueColor, orangeColor, greenColor, yellowColor]
        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
        let randomColor = colors[randomIndex]
        return randomColor.withAlphaComponent(opacity)
    }

    // MARK: Borders
    
    class func addBottomBorder(toLayer layer: CALayer, onFrame frame: CGRect, color: CGColor) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color
        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: frame.size.height)
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
}
