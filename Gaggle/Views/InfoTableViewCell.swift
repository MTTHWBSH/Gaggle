//
//  InfoTableViewCell.swift
//  Gaggle
//
//  Created by Matt Bush on 5/19/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var subtitleLabel: SecondaryLabel!
    @IBOutlet weak var forwardImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        setup()
    }
    
    func setup() {
        contentView.backgroundColor = selected ? Style.whiteColor : Style.whiteColor
        forwardImage.tintColor = Style.blackColor
        selectionStyle = .None
        separatorInset = UIEdgeInsetsZero
        layoutMargins = UIEdgeInsetsZero
    }
    
}
