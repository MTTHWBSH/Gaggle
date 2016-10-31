//
//  ViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }
    
    func styleView() {
        view.backgroundColor = Style.lightGrayColor
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
}
