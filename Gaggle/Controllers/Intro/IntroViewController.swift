//
//  IntroViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 5/6/15.
//  Copyright (c) 2015 Matthew Bush. All rights reserved.
//

import UIKit
import EAIntroView

class IntroViewController: ViewController, EAIntroDelegate {
    
    @IBOutlet weak var introViewContainer: UIView!
    var introView: EAIntroView!
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Intro")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (introView == nil) {
            setupIntroViews()
            setupSkipButton()
        }
    }
    
    override func styleView() {
        super.styleView()
        view.backgroundColor = Style.whiteColor
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
        
        introView.addConstraint(NSLayoutConstraint(item:self.introView, attribute:.bottom, relatedBy: .equal, toItem: self.introView.pageControl, attribute: .bottom, multiplier: 1, constant: 10.0))
        
        introView.show(in: self.introViewContainer, animateDuration: 0.3)
        introView.pageControl.pageIndicatorTintColor = Style.grayColor
        introView.pageControl.currentPageIndicatorTintColor = Style.blueColor
        
    }
    
    func setupSkipButton() {
        let button = Button()
        button.setTitle("Skip", for: UIControlState())
        button.addTarget(self, action: #selector(skipIntro), for: .touchUpInside)
        introView.skipButton = button
        introView.skipButton.isEnabled = true
    }
    
    func skipIntro() {
        Analytics.logEvent("Intro", action: "Skip", Label: "Skip Button Pressed", key: "")
        showFeed()
    }
    
    func showFeed() {
        if let nc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as? TabBarController {
            present(nc, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Login") {
            if let nc = segue.destination as? NavigationController, let vc = nc.topViewController as? LoginSignupViewController {
                vc.selectedLogin = true
                vc.title = "Login"
                vc.loginSignupButtonText = "Login"
            }
        } else if (segue.identifier == "Signup") {
            if let nc = segue.destination as? NavigationController, let vc = nc.topViewController as? LoginSignupViewController {
                vc.selectedLogin = false
                vc.title = "Sign Up"
                vc.loginSignupButtonText = "Sign Up"
            }
        }
    }
    
    func intro(_ introView: EAIntroView!, pageAppeared page: EAIntroPage!, with pageIndex: UInt) {
        if let view = page.customView as? IntroView {
            view.titleLabel.text = ""
            view.subtitleLabel.text = ""
            view.animateText()
        }
    }
    
    // MARK: Actions

    @IBAction func loginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Login", sender: self)
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Signup", sender: self)
    }
    
}

