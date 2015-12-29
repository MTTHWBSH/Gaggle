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
//        PFUser.logInWithUsernameInBackground(user, password: password) {
//            (user: PFUser!, error: NSError!) -> Void in
//            if user != nil {
//                
//            } else {
//                
//            }
//        }
    }
    
    func trySignup(user: String, password: String) {
        
    }
    
}
