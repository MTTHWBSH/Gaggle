//
//  NavigationController.swift
//  Gaggle
//
//  Created by Matthew Bush on 9/19/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }
    
    func styleView() {
        navigationBar.barTintColor = Style.lightGrayColor
        navigationBar.tintColor = Style.blackColor
        navigationBar.translucent = false
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: Style.blackColor, NSFontAttributeName: Style.boldFontWithSize(16.0)]
        navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
    }

}
