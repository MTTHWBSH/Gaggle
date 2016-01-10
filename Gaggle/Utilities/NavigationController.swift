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
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = Style.whiteColor
        navigationBar.tintColor = Style.blackColor
        navigationBar.translucent = false
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: Style.blackColor, NSFontAttributeName: Style.lightFontWithSize(18.0)]
        navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        navigationBar.backIndicatorImage = UIImage(named: "Back")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Back")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }

}
