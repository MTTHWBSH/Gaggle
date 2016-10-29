//
//  InfoTableViewCell.swift
//  Gaggle
//
//  Created by Matt Bush on 5/19/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var primaryLabel: Label!
    @IBOutlet weak var secondaryLabel: SecondaryLabel!
    @IBOutlet weak var forwardImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        contentView.backgroundColor = Style.whiteColor
        forwardImage.tintColor = Style.blackColor
        selectionStyle = .none
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
}
