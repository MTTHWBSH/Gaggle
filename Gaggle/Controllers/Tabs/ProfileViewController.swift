//
//  ProfileViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/4/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Parse
import PureLayout

class ProfileViewController: FeedViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    override func refresh() {
        guard let user = PFUser.currentUser() else { return }
        viewModel = FeedViewModel(query: FeedQuery.allPosts(forUser: user))
        super.refresh()
    }
    
    func setup() {
        userNameHidden = true
        if Session.currentSession.loggedIn()  {
            guard let user = PFUser.currentUser() else { return }
            navigationItem.title = user.username
            viewModel = FeedViewModel(query: FeedQuery.allPosts(forUser: user))
            let rightBarButtonItem = BarButtonItem(image: UIImage(named: "Gear"), style: .Plain, target: self, action: #selector(settingsButtonPressed))
            navigationItem.rightBarButtonItem = rightBarButtonItem
        } else {
            refreshControl = nil
            tableView.contentInset = UIEdgeInsetsZero
            tableView.bounces = false
            view.backgroundColor = Style.whiteColor
            navigationItem.title = "Profile"
            navigationItem.rightBarButtonItem = nil
            addSignedOutView()
        }
    }
    
    func addSignedOutView() {
        guard let signedOutView = NSBundle.mainBundle().loadNibNamed("SignedOutView", owner: self, options: nil).first as? SignedOutView else { return }
        signedOutView.alertLabel.text = "To manage your profile please"
        signedOutView.loginTapped = { [weak self] void in self?.showLogin() }
        signedOutView.signupTapped = { [weak self] void in self?.showSignup() }
        navigationController?.view.addSubview(signedOutView)
        signedOutView.autoPinEdgesToSuperviewEdges()
    }
    
    func settingsButtonPressed() {
        performSegueWithIdentifier("ToSettings", sender: self)
    }
    
    func showLogin() {
        if let nc = Router.loginNavigationController() {
            presentViewController(nc, animated: true, completion: nil)
        }
    }
    
    func showSignup() {
        if let nc = Router.signupNavigationController() {
            presentViewController(nc, animated: true, completion: nil)
        }
    }
    
}
