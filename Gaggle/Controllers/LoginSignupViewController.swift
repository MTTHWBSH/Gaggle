//
//  LoginSignupViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 9/19/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var loginSignupButton: PrimaryButton!
    
    var selectedLogin: Bool!
    var loginSignupButtonText = ""
    
    @IBAction func closeButtonPressed(sender: BarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        Style.addBottomBorder(toLayer: usernameTextField.layer, onFrame: usernameTextField.frame)
        Style.addBottomBorder(toLayer: passwordTextField.layer, onFrame: passwordTextField.frame)
        usernameTextField.tintColor = Style.redColor
        usernameTextField.autocapitalizationType = .None
        usernameTextField.autocorrectionType = .No
        passwordTextField.autocapitalizationType = .None
        passwordTextField.autocorrectionType = .No
        passwordTextField.tintColor = Style.redColor
        brandLabel.textColor = Style.redColor
        brandLabel.font = Style.regularFontWithSize(32.0)
        loginSignupButton.setTitle(loginSignupButtonText, forState: .Normal)
    }
    
    @IBAction func loginSignupButtonPressed(sender: AnyObject) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            if let user = usernameTextField.text, let password = passwordTextField.text {
                if !selectedLogin {
                    trySignup(user, password: password)
                } else {
                    tryLogin(user, password: password)
                }
            }
        } else {
            let alertText = "Looks like there are some empty fields, please fill them out and try again."
            SVProgressHUD.showErrorWithStatus(alertText, maskType: SVProgressHUDMaskType.Black)
        }
    }
    
    func tryLogin(user: String, password: String) {
        SVProgressHUD.showWithStatus("Loggin in", maskType: .Black)
        
        PFUser.logInWithUsernameInBackground(user, password: password, block: { (user, error) -> Void in
            
            SVProgressHUD.dismiss()
            
            if ((user) != nil) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main") as! TabBarController
                    self.presentViewController(nc, animated: true, completion: nil)
                })
                
            } else {
                SVProgressHUD.showWithStatus("Login failed, please try again", maskType: .Black)
            }
        })
    }

    func trySignup(user: String, password: String) {
        SVProgressHUD.showWithStatus("Signing up", maskType: .Black)
        
        let newUser = PFUser()
        newUser.username = user
        newUser.password = password
        
        newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
            SVProgressHUD.dismiss()
            
            if ((error) != nil) {
                SVProgressHUD.showWithStatus("Sign up failed, please try again", maskType: .Black)
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let vc:UIViewController = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("Feed") as! FeedViewController
                    self.presentViewController(vc, animated: true, completion: nil)
                })
            }
        })
    }
    
}
