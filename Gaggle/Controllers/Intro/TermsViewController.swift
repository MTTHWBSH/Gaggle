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
    var agreePressed: ((Void) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        styleTextView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTextView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Terms")
    }
    
    func setup() {
        if fromSettings == false { setupAgreeButton() }
        view.backgroundColor = Style.whiteColor
    }
    
    func setupTextView() {
        termsTextView.layoutMargins = UIEdgeInsets.zero
        termsTextView.contentInset = UIEdgeInsets.zero
        termsTextView.contentOffset = CGPoint.zero
    }
    
    func styleTextView() {
       termsTextView.font = Style.regularFontWithSize(14.0)
        termsTextView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func setupAgreeButton() {
        let rightBarButtonItem = BarButtonItem(title: "Agree", style: .plain, target: self, action: #selector(agree))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func agree() {
        UserDefaults.standard.set(true, forKey: Constants.HasShownTerms)
        agreePressed?()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func closePressed(_ sender: AnyObject) {
        if fromSettings ?? false {
            dismiss(animated: true, completion: nil)
        } else {
            guard let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewController(withIdentifier: "Intro") as? IntroViewController else { return }
            present(vc, animated: true, completion: nil)
        }
    }
    
}
