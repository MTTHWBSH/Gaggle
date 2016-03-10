//
//  EditPostViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/12/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class EditPostViewController: ViewController, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var submitButton: PrimaryButton!
    @IBOutlet var maskView: UIView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var subtitleTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    var image: UIImage?
    var photoFile: PFFile?
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
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
        if let image = image {
           shouldUploadImage(image, width: 550.0)
        }
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
    
    // MARK: Text Field
    
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
    
    // MARK: Post Upload
    
    func shouldUploadImage(image: UIImage, width: CGFloat) {
        let scale = width / image.size.width
        let height = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        image.drawInRect(CGRectMake(0, 0, width, height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let imageData: NSData = UIImageJPEGRepresentation(resizedImage, 1.0) else { return }
        photoFile = PFFile(data: imageData)
        
        if let photoFile = photoFile {
            photoFile.saveInBackgroundWithBlock { (completion, error) in
                if completion {
                    print("Photo file save in background completed")
                } else {
                    print(error?.description)
                }
            }
        }
    }
    
    func uploadPost() {
        SVProgressHUD.showWithMaskType(.Black)
        guard let currentUserID = PFUser.currentUser()?.objectId, photoFile = photoFile else {
            let alertText = "An error occured while uploading your photo. Please try again."
            SVProgressHUD.showErrorWithStatus(alertText, maskType: SVProgressHUDMaskType.Black)
            return
        }
        
        let post = PFObject(className: Constants.PostClassKey)
        post.setObject(currentUserID, forKey: Constants.PostUserIDKey)
        post.setObject(photoFile, forKey: Constants.PostImageKey)
        if let title = titleTextField.text, subtitle = subtitleTextField.text {
            post.setObject(title, forKey: Constants.PostTitleKey)
            post.setObject(subtitle, forKey: Constants.PostSubtitleKey)
        }
        
        post.saveInBackgroundWithBlock { (completion, error) in
            SVProgressHUD.dismiss()
            if completion {
                print("Saved post: \(post)")
            } else {
                print("Post failed to save: \(error)")
                let alertText = "An error occured while uploading your photo: \(error)"
                SVProgressHUD.showErrorWithStatus(alertText, maskType: SVProgressHUDMaskType.Black)
                return
            }
        }
        
        parentViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func submitPost() {
        if titleTextField.text != "" && subtitleTextField.text != "" {
            uploadPost()
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
        
        if let activeView = activeView() {
            scrollView.scrollRectToVisible(activeView.frame, animated: false)
        }
    }
    
    func activeView() -> UIView? {
        return [titleTextField, subtitleTextField].filter { return $0.isFirstResponder() }.first
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
