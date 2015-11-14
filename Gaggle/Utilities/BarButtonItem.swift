//
//  BarButtonItem.swift
//  Gaggle
//
//  Created by Matthew Bush on 9/19/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import UIKit

class BarButtonItem: UIBarButtonItem {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UIBarButtonItem.appearance().tintColor = Style.blackColor
    }

}
