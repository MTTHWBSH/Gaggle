//
//  Label.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class Label: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    func style() {
        font = Style.regularFontWithSize(14.0)
        textColor = Style.blackColor
    }
    
}

class SecondaryLabel: Label {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    override func style() {
        font = Style.regularFontWithSize(14.0)
        textColor = Style.grayColor
    }
    
}
