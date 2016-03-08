//
//  FeedViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 12/29/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit

class FeedViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        navigationItem.title = "Gaggle"
        
        if Session.currentSession.loggedIn()  {
            // hide empty state
        } else {
            // show empty state
        }
    }
    
}
