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
    
    var userButtonTapped: ((Void) -> Void)?

    var detailsShown = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleView()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if detailsShown { hideDetails(duration: 0.0) }
        userButton.setTitle(nil, for: UIControlState())
        timeLabel.attributedText = nil
        postImageView?.image = UIImage(named: "PhotoPlaceholder")
        titleLabel.text = nil
        subtitleLabel.text = nil
    }

    func styleView() {
        backgroundColor = Style.lightGrayColor
        postDetailsView.backgroundColor = Style.randomBrandColor(withOpacity: 0.85)
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        timeLabel.clipsToBounds = false
        titleLabel.font = Style.regularFontWithSize(32.0)
        subtitleLabel.font = Style.regularFontWithSize(32.0)
        postDetailsView.alpha = 0.0
    }
    
    func setupView() {
        wrapperView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(detailsTapped))
        wrapperView.addGestureRecognizer(gestureRecognizer)
    }
    
    func detailsTapped() {
        let label = detailsShown ? "Hide Details" : "Show Details"
        Analytics.logEvent("Post", action: "Image Tapped", Label: label, key: "")
        detailsShown ? hideDetails(duration: 0.6) : showDetails(duration: 0.6)
    }
    
    func hideDetails(duration: Double) {
        detailsShown = false
        Animation.fadeOut(postDetailsView, duration: duration)
    }
    
    func showDetails(duration: Double) {
        detailsShown = true
        Animation.fadeIn(postDetailsView, duration: duration)
    }
    
    @IBAction func userButtonPressed(_ sender: AnyObject) {
        Analytics.logEvent("Post", action: "User Button", Label: "User Button Pressed", key: "")
        userButtonTapped?()
    }
    
}
