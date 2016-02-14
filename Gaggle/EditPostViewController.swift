//
//  EditPostViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/12/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class EditPostViewController: ViewController {

    @IBOutlet var imageView: UIView!
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
        setupImage()
    }
    
    func setupImage() {
        guard let image = image else { return }
        imageView = UIImageView(image: image)
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
