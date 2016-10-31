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

class LoginSignupViewController: ViewController, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var brandLabel: UILabel!
    @IBOutlet var loginSignupButton: PrimaryButton!
    @IBOutlet var scrollView: UIScrollView!
    
    var selectedLogin: Bool!
    var loginSignupButtonText = ""
    
    @IBAction func closeButtonPressed(_ sender: BarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        styleView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Login/Signup")
    }
    
    func setupView() {
        setupLogo()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        scrollView.delegate = self
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        loginSignupButton.setTitle(loginSignupButtonText, for: UIControlState())

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func styleView() {
        Style.addBottomBorder(toLayer: usernameTextField.layer, onFrame: usernameTextField.frame, color: Style.grayColor.cgColor)
        Style.addBottomBorder(toLayer: passwordTextField.layer, onFrame: passwordTextField.frame, color: Style.grayColor.cgColor)
        usernameTextField.tintColor = Style.blueColor
        passwordTextField.tintColor = Style.blueColor
        brandLabel.textColor = Style.blueColor
        brandLabel.font = Style.brandFontWithSize(72.0)
    }
    
    func setupLogo() {
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: "GooseWordMark")
        guard let image = attachment.image else { return }
        attachment.bounds = CGRect(x: 0, y: -18.0, width: image.size.width, height: image.size.height)
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let brandString = NSMutableAttributedString(string: "ga")
        let brandStringFinish = NSMutableAttributedString(string: "gle")
        brandString.append(attachmentString)
        brandString.append(brandStringFinish)
        
        brandLabel.attributedText = brandString
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginSignupButtonPressed(_ sender: AnyObject) {
        tryLoginSignup()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            tryLoginSignup()
        }
        return true
    }
    
    // MARK: Keyboard Avoidance
    
    func keyboardWillShow(_ note: Notification) {
        var keyboardFrame = (note.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
        
        if let activeView = activeView() {
            scrollView.scrollRectToVisible(activeView.frame, animated: false)
        }
    }
    
    func activeView() -> UIView? {
        return [usernameTextField, passwordTextField].filter { return $0.isFirstResponder }.first
    }
    
    func keyboardWillHide(_ note: Notification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
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
            SVProgressHUD.showError(withStatus: alertText)
        }
    }
    
    func tryLogin(_ user: String, password: String) {
        Analytics.logEvent("Login/Signup", action: "Login", Label: "Login Button Pressed", key: "")
        SVProgressHUD.show(withStatus: "Logging in")
        
        PFUser.logInWithUsername(inBackground: user, password: password, block: { (user, error) -> Void in
            
            if ((user) != nil) {
                DispatchQueue.main.async(execute: { () -> Void in
                    SVProgressHUD.dismiss()
                    self.showFeed()
                })
                
            } else if ((error) != nil) {
                if let error = error {
                    SVProgressHUD.showError(withStatus: error.localizedDescription)
                }
            } else {
                SVProgressHUD.showError(withStatus: "Login failed, please try again")
            }
        })
    }

    func trySignup(_ user: String, password: String) {
        Analytics.logEvent("Login/Signup", action: "Signup", Label: "Signup Button Pressed", key: "")
        SVProgressHUD.show(withStatus: "Signing up")
        
        let newUser = PFUser()
        newUser.username = user
        newUser.password = password
        
        newUser.signUpInBackground(block: { (succeed, error) -> Void in
            if ((error) != nil) {
                if let error = error {
                    SVProgressHUD.showError(withStatus: error.localizedDescription)
                }
            } else {
                DispatchQueue.main.async(execute: { () -> Void in
                    SVProgressHUD.dismiss()
                    self.showFeed()
                })
            }
        })
    }
    
    func showFeed() {
        if let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as? TabBarController {
            self.present(nc, animated: true, completion: nil)
        }
    }
    
}
