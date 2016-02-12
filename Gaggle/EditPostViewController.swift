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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    func setup() {
        setupImage()
    }
    
    func setupImage() {
        guard let image = image else { return }
        imageView = UIImageView(image: image)
        imageView.setNeedsDisplay()
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
