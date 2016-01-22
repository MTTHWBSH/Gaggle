//
//  CameraViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class CameraViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        navigationItem.title = "Photo"
        view.backgroundColor = Style.whiteColor
        if Session.currentSession.loggedIn()  {
            guard let user = PFUser.currentUser() else { return }
            // hide empty state
        } else {
            // show empty state
        }
    }
    
}