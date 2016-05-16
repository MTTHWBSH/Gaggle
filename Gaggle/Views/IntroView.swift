//
//  IntroView.swift
//  Gaggle
//
//  Created by Matthew Bush on 6/11/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import UIKit

class IntroView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var title: String? {
        didSet {
            titleLabel.text = ""
            setup()
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = ""
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    class func initWith(title: String, subtitle: String, image: UIImage) -> IntroView {
        guard let introView: IntroView = NSBundle.mainBundle().loadNibNamed("IntroView", owner: self, options: nil).first as? IntroView else { return IntroView() }
        
        introView.title = title.capitalizedString
        introView.subtitle = subtitle.capitalizedString
        introView.imageView.image = image
        
        return introView
    }
    
    func setup() {
        self.backgroundColor = UIColor.whiteColor()
        titleLabel.textColor = Style.grayColor
        subtitleLabel.textColor = Style.grayColor
    }
    
    func animateText() {
        titleLabel.text = ""
        subtitleLabel.text = ""
        titleLabel.layer.removeAllAnimations()
        subtitleLabel.layer.removeAllAnimations()
        Animation.punchText(title!, label: titleLabel) {
            Animation.punchText(self.subtitle!, label: self.subtitleLabel, completion: nil)
        }
    }
    
}
