//
//  TabBarController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UINavigationControllerDelegate {
    
    var navController: UINavigationController?
    
    // MARK:- UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTabBar()
        navController = NavigationController()
    }
    
    // MARK:- ()
    
    func styleTabBar() {
        removeTabTitles()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = Style.orangeColorSelected
        tabBar.barTintColor = Style.whiteColor
        tabBar.translucent = false
        for tab in tabBar.items! {
            tab.image = tab.image?.imageWithRenderingMode(.AlwaysOriginal)
        }
    }
    
    func removeTabTitles() {
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
    }
}
