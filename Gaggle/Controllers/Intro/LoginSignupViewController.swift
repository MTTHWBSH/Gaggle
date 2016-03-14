//
//  LoginSignupViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 9/19/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class LoginSignupViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var loginSignupButton: PrimaryButton!
    @IBOutlet var scrollView: UIScrollView!
    
    var selectedLogin: Bool!
    var loginSignupButtonText = ""
    
    @IBAction func closeButtonPressed(sender: BarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        styleView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func setupView() {
        setupLogo()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        scrollView.delegate = self
        usernameTextField.autocapitalizationType = .None
        usernameTextField.autocorrectionType = .No
        passwordTextField.autocapitalizationType = .None
        passwordTextField.autocorrectionType = .No
        loginSignupButton.setTitle(loginSignupButtonText, forState: .Normal)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func styleView() {
        Style.addBottomBorder(toLayer: usernameTextField.layer, onFrame: usernameTextField.frame, color: Style.grayColor.CGColor)
        Style.addBottomBorder(toLayer: passwordTextField.layer, onFrame: passwordTextField.frame, color: Style.grayColor.CGColor)
        usernameTextField.tintColor = Style.blueColor
        passwordTextField.tintColor = Style.blueColor
        brandLabel.textColor = Style.blueColor
        brandLabel.font = Style.brandFontWithSize(72.0)
    }
    
    func setupLogo() {
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: "GooseWordMark")
        guard let image = attachment.image else { return }
        attachment.bounds = CGRectMake(0, -18.0, image.size.width, image.size.height)
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let brandString = NSMutableAttributedString(string: "ga")
        let brandStringFinish = NSMutableAttributedString(string: "gle")
        brandString.appendAttributedString(attachmentString)
        brandString.appendAttributedString(brandStringFinish)
        
        brandLabel.attributedText = brandString
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginSignupButtonPressed(sender: AnyObject) {
        tryLoginSignup()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            tryLoginSignup()
        }
        return true
    }
    
    // MARK: Keyboard Avoidance
    
    func keyboardWillShow(note: NSNotification) {
        var keyboardFrame = (note.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardFrame = view.convertRect(keyboardFrame, fromView: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
        
        if let activeView = activeView() {
            scrollView.scrollRectToVisible(activeView.frame, animated: false)
        }
    }
    
    func activeView() -> UIView? {
        return [usernameTextField, passwordTextField].filter { return $0.isFirstResponder() }.first
    }
    
    func keyboardWillHide(note: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInset
    }
    
    // MARK: Login/Signup
    
    func tryLoginSignup() {
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
        SVProgressHUD.showWithStatus("Logging in", maskType: .Black)
        
        PFUser.logInWithUsernameInBackground(user, password: password, block: { (user, error) -> Void in
            
            SVProgressHUD.dismiss()
            
            if ((user) != nil) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main") as! TabBarController
                    self.presentViewController(nc, animated: true, completion: nil)
                })
                
            } else if ((error) != nil) {
                if let error = error {
                    SVProgressHUD.showErrorWithStatus(error.localizedDescription, maskType: .Black)
                }
            } else {
                SVProgressHUD.showErrorWithStatus("Login failed, please try again", maskType: .Black)
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
                if let error = error {
                    SVProgressHUD.showErrorWithStatus(error.localizedDescription, maskType: .Black)
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main") as! TabBarController
                    self.presentViewController(nc, animated: true, completion: nil)
                })
            }
        })
    }
    
}
