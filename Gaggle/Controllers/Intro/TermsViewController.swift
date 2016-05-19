//
//  TermsViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 5/19/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class TermsViewController: ViewController {
    
    @IBOutlet weak var termsTextView: UITextView!
    @IBOutlet weak var agreeBarButtonItem: BarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = Style.whiteColor
        termsTextView.font = Style.regularFontWithSize(14.0)
        termsTextView.layoutMargins = UIEdgeInsetsZero
        termsTextView.contentInset = UIEdgeInsetsZero
        termsTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
        termsTextView.scrollRangeToVisible(NSMakeRange(0, 0))
    }

    @IBAction func closePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func agreePressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
