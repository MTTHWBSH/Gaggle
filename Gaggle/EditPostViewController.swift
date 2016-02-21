//
//  EditPostViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/12/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class EditPostViewController: ViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var submitButton: PrimaryButton!
    @IBOutlet var maskView: UIView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var subtitleTextField: UITextField!
    
    var image: UIImage?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "Share"
        view.backgroundColor = Style.whiteColor
        submitButton.enabled = false
        setupImage()
    }
    
    func setupImage() {
        imageView.image = image
    }
    
    override func styleView() {
        maskView.backgroundColor = Style.blueColor.colorWithAlphaComponent(0.8)
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
