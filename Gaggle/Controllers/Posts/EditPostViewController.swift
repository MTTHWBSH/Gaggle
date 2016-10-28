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
    
    @IBOutlet var imageViewTopMargin: NSLayoutConstraint!
    
    var image: UIImage?
    var photoFile: PFFile?
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Edit Post")
    }
    
    func setup() {
        title = "Share"
        imageView.image = image
        
        titleTextField.delegate = self
        subtitleTextField.delegate = self
        titleTextField.autocapitalizationType = .none
        titleTextField.autocorrectionType = .no
        subtitleTextField.autocapitalizationType = .none
        subtitleTextField.autocorrectionType = .no
        
        scrollView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        if let image = image {
           shouldUploadImage(image, width: 550.0)
        }
    }
    
    override func styleView() {
        view.backgroundColor = Style.whiteColor
        
        if UIScreen.main.nativeBounds.height <= 960 {
            imageViewTopMargin.constant = 0
        }
        
        maskView.backgroundColor = Style.randomBrandColor(withOpacity: 0.85)
        titleTextField.tintColor = Style.whiteColor
        titleTextField.textColor = Style.whiteColor
        titleTextField.font = Style.regularFontWithSize(32.0)
        subtitleTextField.tintColor = Style.whiteColor
        subtitleTextField.textColor = Style.whiteColor
        subtitleTextField.font = Style.regularFontWithSize(32.0)
    }
    
    // MARK: Text Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
    
    func shouldUploadImage(_ image: UIImage, width: CGFloat) {
        let scale = width / image.size.width
        let height = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let imageData: Data = UIImageJPEGRepresentation(resizedImage!, 1.0) else { return }
        photoFile = PFFile(data: imageData)
        
        if let photoFile = photoFile {
            photoFile.saveInBackground { (completion, error) in
                if completion {
                    print("Photo file save in background completed")
                } else {
                    print(error?.localizedDescription ?? "Error saving file in background")
                }
            }
        }
    }
    
    func uploadPost() {
        SVProgressHUD.showProgress(0.1, status: "Uploading")
        guard let currentUserID = PFUser.current()?.objectId, let photoFile = photoFile else {
            let alertText = "An error occured while uploading your photo. Please try again."
            SVProgressHUD.showError(withStatus: alertText)
            return
        }
        
        let post = PFObject(className: Constants.PostClassKey)
        post.setObject(currentUserID, forKey: Constants.PostUserIDKey)
        post.setObject(photoFile, forKey: Constants.PostImageKey)
        if let title = titleTextField.text, let subtitle = subtitleTextField.text {
            post.setObject(title, forKey: Constants.PostTitleKey)
            post.setObject(subtitle, forKey: Constants.PostSubtitleKey)
        }
        
        post.saveInBackground { (completion, error) in
            SVProgressHUD.dismiss()
            if completion {
                SVProgressHUD.showProgress(1.0, status: "Complete")
            } else {
                print("Post failed to save: \(error)")
                let alertText = "An error occured while uploading your photo"
                SVProgressHUD.showError(withStatus: alertText)
                return
            }
        }
        
        guard let parentVC = parent as? NavigationController, let presentingVC = presentingViewController as? TabBarController else { return }
        presentingVC.selectedIndex = 0
        
        guard let selectedVC = presentingVC.selectedViewController as? NavigationController, let vc = selectedVC.topViewController as? MainFeedViewController else { return }
        vc.setup()
        parentVC.dismiss(animated: true, completion: nil)
    }
    
    func submitPost() {
        Analytics.logEvent("Post", action: "Submit", Label: "Submit Button Pressed", key: "")
        if titleTextField.text != "" && subtitleTextField.text != "" {
            uploadPost()
        } else {
            let alertText = "Looks like there are some empty fields, please fill them out and try again."
            SVProgressHUD.showError(withStatus: alertText)
        }
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
        return [titleTextField, subtitleTextField].filter { return $0.isFirstResponder }.first
    }
    
    func keyboardWillHide(_ note: Notification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    // MARK: IBActions
    
    @IBAction func submitButtonPressed(_ sender: AnyObject) {
        submitPost()
    }
    
    @IBAction func closeButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
