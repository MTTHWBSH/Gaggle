//
//  SignedOutView.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/7/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class SignedOutView: UIView {
    
    @IBOutlet var alertLabel: UILabel!
    
    var loginTapped: (Void -> Void)?
    var signupTapped: (Void -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Style.whiteColor
    }
    
    @IBAction func loginPressed(sender: AnyObject) {
        loginTapped?()
    }
    
    @IBAction func signupPressed(sender: AnyObject) {
        signupTapped?()
    }
    
}
