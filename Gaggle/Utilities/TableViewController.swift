//
//  TableViewController.swift
//  Gaggle
//
//  Created by Matt Bush on 5/6/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Reachability.tryReachability(self)
    }
    
    func styleView() {
        view.backgroundColor = Style.lightGrayColor
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
    
}
