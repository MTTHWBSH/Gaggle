//
//  Router.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/7/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Foundation
import UIKit

class Router {
    
    class func loginNavigationController() -> NavigationController? {
        if let nc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("LoginSignupNavigationController") as? NavigationController {
            if let vc = nc.topViewController as? LoginSignupViewController {
                vc.selectedLogin = true
                vc.title = "Login"
                vc.loginSignupButtonText = "Login"
                return nc
            }
        }
        return nil
    }
    
    class func signupNavigationController() -> NavigationController? {
        if let nc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("LoginSignupNavigationController") as? NavigationController {
            if let vc = nc.topViewController as? LoginSignupViewController {
                vc.selectedLogin = false
                vc.title = "Sign Up"
                vc.loginSignupButtonText = "Sign Up"
                return nc
            }
        }
        return nil
    }
    
}
