//
//  ProfileEmptyView.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/9/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class ProfileEmptyView: UIView {
    
    @IBOutlet var headerLabel: UILabel!
    
    var getStartedTapped: (Void -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Style.whiteColor
        headerLabel.text = "Your posts will appear here.\nGive your first one a try!"
    }
    
    @IBAction func getStartedTapped(sender: AnyObject) {
        getStartedTapped?()
    }
    
}
