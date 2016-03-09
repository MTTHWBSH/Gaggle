//
//  SeparatorView.swift
//  Gaggle
//
//  Created by Matthew Bush on 7/10/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import UIKit

class SeparatorView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Style.grayColor
    }
    
}

class SeparatorViewWhite: SeparatorView {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Style.whiteColor
    }
}
