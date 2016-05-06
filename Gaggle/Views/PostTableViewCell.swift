//
//  PostTableViewCell.swift
//  Gaggle
//
//  Created by Matthew Bush on 4/8/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit
import Parse

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userButton: SecondaryTextButton!
    @IBOutlet weak var timeLabel: SecondaryLabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postDetailsView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    
    var userButtonTapped: (Void -> Void)?

    var detailsShown = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleView()
        setupView()
    }
    
    func styleView() {
        backgroundColor = Style.lightGrayColor
        postDetailsView.backgroundColor = Style.randomBrandColor(withOpacity: 0.85)
        separatorInset = UIEdgeInsetsZero
        layoutMargins = UIEdgeInsetsZero
        timeLabel.clipsToBounds = false
        titleLabel.font = Style.regularFontWithSize(32.0)
        subtitleLabel.font = Style.regularFontWithSize(32.0)
        postDetailsView.alpha = 0.0
    }
    
    func setupView() {
        wrapperView.userInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(detailsTapped))
        wrapperView.addGestureRecognizer(gestureRecognizer)
    }
    
    func detailsTapped() {
        detailsShown ? hideDetails() : showDetails()
    }
    
    func hideDetails() {
        detailsShown = false
        Animation.fadeOut(postDetailsView, duration: 0.6)
    }
    
    func showDetails() {
        detailsShown = true
        Animation.fadeIn(postDetailsView, duration: 0.6)
    }
    
    @IBAction func userButtonPressed(sender: AnyObject) {
        userButtonTapped?()
    }
    
}
