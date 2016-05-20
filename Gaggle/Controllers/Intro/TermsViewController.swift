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
    
    var fromSettings: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        if fromSettings == false ?? false { setupAgreeButton() }
        view.backgroundColor = Style.whiteColor
        termsTextView.font = Style.regularFontWithSize(14.0)
        termsTextView.layoutMargins = UIEdgeInsetsZero
        termsTextView.contentInset = UIEdgeInsetsZero
        termsTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
        termsTextView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    func setupAgreeButton() {
        let rightBarButtonItem = BarButtonItem(title: "Agree", style: .Plain, target: self, action: #selector(agree))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func agree() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: Constants.HasShownTerms)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func closePressed(sender: AnyObject) {
        if fromSettings ?? false {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            guard let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewControllerWithIdentifier("Intro") as? IntroViewController else { return }
            presentViewController(vc, animated: true, completion: nil)
        }
    }
    
}
