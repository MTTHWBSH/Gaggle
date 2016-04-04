//
//  IntroViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/6/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import UIKit
import EAIntroView

class IntroViewController: UIViewController, EAIntroDelegate {
    
    @IBOutlet weak var introViewContainer: UIView!
    var introView: EAIntroView!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (self.introView == nil) {
            setupIntroViews()
            setupSkipButton()
        }
    }
    
    func setupIntroViews() {
        let image1 = UIImage(named: "Geese")
        let image2 = UIImage(named: "Owls")
        let image3 = UIImage(named: "Programmers")
        
        let title1 = "Geese"
        let title2 = "Owls"
        let title3 = "Programmers"
        
        let subtitle1 = "Gaggle"
        let subtitle2 = "Parliament"
        let subtitle3 = "Repository"
        
        let intro1: IntroView = IntroView.initWith(title1, subtitle: subtitle1, image: image1!)
        let intro2: IntroView = IntroView.initWith(title2, subtitle: subtitle2, image: image2!)
        let intro3: IntroView = IntroView.initWith(title3, subtitle: subtitle3, image: image3!)
    
        let page1: EAIntroPage = EAIntroPage(customView: intro1)
        let page2: EAIntroPage = EAIntroPage(customView: intro2)
        let page3: EAIntroPage = EAIntroPage(customView: intro3)
        
        introView = EAIntroView(frame: self.introViewContainer.bounds, andPages: [page1, page2, page3])
        introView.delegate = self
        introView.swipeToExit = false
        
        introView.addConstraint(NSLayoutConstraint(item:self.introView, attribute:.Bottom, relatedBy: .Equal, toItem: self.introView.pageControl, attribute: .Bottom, multiplier: 1, constant: 10.0))
        
        introView.showInView(self.introViewContainer, animateDuration: 0.3)
        introView.pageControl.pageIndicatorTintColor = Style.grayColor
        introView.pageControl.currentPageIndicatorTintColor = Style.blueColor
        
    }
    
    func setupSkipButton() {
        let button = Button()
        button.setTitle("Skip", forState: .Normal)
        button.addTarget(self, action: #selector(skipIntro), forControlEvents: .TouchUpInside)
        introView.skipButton = button
        introView.skipButton.enabled = true
    }
    
    func skipIntro() {
        let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Main") as! TabBarController
        if let feedVC = tabVC.selectedViewController as? FeedViewController {
            feedVC.viewModel = FeedViewModel(query: FeedQuery.allPosts())
        }
        presentViewController(tabVC, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "Login") {
            let nc = segue.destinationViewController as! NavigationController
            if let vc = nc.topViewController as? LoginSignupViewController {
                vc.selectedLogin = true
                vc.title = "Login"
                vc.loginSignupButtonText = "Login"
            }
        } else if (segue.identifier == "Signup") {
            let nc = segue.destinationViewController as! NavigationController
            if let vc = nc.topViewController as? LoginSignupViewController {
                vc.selectedLogin = false
                vc.title = "Sign Up"
                vc.loginSignupButtonText = "Sign Up"
            }
        }
    }
    
    func intro(introView: EAIntroView!, pageAppeared page: EAIntroPage!, withIndex pageIndex: UInt) {
        if let view = page.customView as? IntroView {
            view.titleLabel.text = ""
            view.subtitleLabel.text = ""
            view.animateText()
        }
    }
    
    // MARK: Actions

    @IBAction func loginPressed(sender: UIButton) {
        performSegueWithIdentifier("Login", sender: self)
    }
    
    @IBAction func signupPressed(sender: UIButton) {
        performSegueWithIdentifier("Signup", sender: self)
    }
    
}

