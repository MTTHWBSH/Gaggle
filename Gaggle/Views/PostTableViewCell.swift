//
//  PostTableViewCell.swift
//  Gaggle
//
//  Created by Matthew Bush on 4/8/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userButton: SecondaryTextButton!
    @IBOutlet weak var timeLabel: SecondaryLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleView()
    }
    
    func styleView() {
        backgroundColor = Style.lightGrayColor
        separatorInset = UIEdgeInsetsZero
        layoutMargins = UIEdgeInsetsZero
        timeLabel.clipsToBounds = false
    }
    
    @IBAction func userButtonPressed(sender: AnyObject) {
        
    }
    
}
