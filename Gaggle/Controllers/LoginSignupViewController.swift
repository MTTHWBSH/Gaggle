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
    
    @IBAction func closeButtonPressed(sender: BarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }
    
    func styleView() {
        Style.addBottomBorder(toLayer: usernameTextField.layer, onFrame: usernameTextField.frame)
        Style.addBottomBorder(toLayer: passwordTextField.layer, onFrame: passwordTextField.frame)
        usernameTextField.tintColor = Style.redColor
        passwordTextField.tintColor = Style.redColor
        brandLabel.textColor = Style.redColor
        brandLabel.font = Style.regularFontWithSize(32.0)
    }
}
