//
//  EditPostViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/12/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class EditPostViewController: ViewController, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var submitButton: PrimaryButton!
    @IBOutlet var maskView: UIView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var subtitleTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    var image: UIImage?
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func setup() {
        title = "Share"
        imageView.image = image
        
        titleTextField.delegate = self
        subtitleTextField.delegate = self
        titleTextField.autocapitalizationType = .None
        titleTextField.autocorrectionType = .No
        subtitleTextField.autocapitalizationType = .None
        subtitleTextField.autocorrectionType = .No
        
        scrollView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func styleView() {
        view.backgroundColor = Style.whiteColor
        
        let maskViewColors = [Style.blueColor, Style.orangeColor, Style.greenColor, Style.yellowColor]
        let randomIndex = Int(arc4random_uniform(UInt32(maskViewColors.count)))
        let randomColor = maskViewColors[randomIndex]
        maskView.backgroundColor = randomColor.colorWithAlphaComponent(0.85)
        
        titleTextField.tintColor = Style.whiteColor
        titleTextField.textColor = Style.whiteColor
        titleTextField.font = Style.regularFontWithSize(32.0)
        subtitleTextField.tintColor = Style.whiteColor
        subtitleTextField.textColor = Style.whiteColor
        subtitleTextField.font = Style.regularFontWithSize(32.0)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == titleTextField {
            subtitleTextField.becomeFirstResponder()
        } else if textField == subtitleTextField {
            subtitleTextField.resignFirstResponder()
        }
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func submitPost() {
        if titleTextField.text != "" && subtitleTextField.text != "" {
            
        } else {
            let alertText = "Looks like there are some empty fields, please fill them out and try again."
            SVProgressHUD.showErrorWithStatus(alertText, maskType: SVProgressHUDMaskType.Black)
        }
    }
    
    // MARK: Keyboard Avoidance
    
    func keyboardWillShow(note: NSNotification) {
        let keyboardFrameEnd: CGRect = (note.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        var scrollViewContentSize: CGSize = scrollView.bounds.size
        scrollViewContentSize.height += keyboardFrameEnd.size.height
        scrollView.contentSize = scrollViewContentSize
        
        var scrollViewContentOffset: CGPoint = scrollView.contentOffset
        scrollViewContentOffset.y = scrollViewContentOffset.y + keyboardFrameEnd.size.height*3.0 - UIScreen.mainScreen().bounds.size.height
        
        scrollView.setContentOffset(scrollViewContentOffset, animated: true)
    }
    
    func keyboardWillHide(note: NSNotification) {
        let keyboardFrameEnd: CGRect = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        var scrollViewContentSize: CGSize = scrollView.bounds.size
        scrollViewContentSize.height -= keyboardFrameEnd.size.height
        UIView.animateWithDuration(0.200, animations: {
            self.scrollView.contentSize = scrollViewContentSize
        })
    }
    
    // MARK: IBActions
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        submitPost()
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
