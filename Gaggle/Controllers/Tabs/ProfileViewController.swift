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
    
    var emptyView: ProfileEmptyView?
    var signedOutView: SignedOutView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        setupActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Profile")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emptyView?.removeFromSuperview()
        signedOutView?.removeFromSuperview()
    }
    
    override func refresh() {
        guard let user = PFUser.current() else { return }
        viewModel = FeedViewModel(query: FeedQuery.allPosts(forUser: user))
        super.refresh()
    }
    
    func setup() {
        userNameHidden = true
        if Session.currentSession.loggedIn()  {
            guard let user = PFUser.current() else { return }
            navigationItem.title = user.username
            viewModel = FeedViewModel(query: FeedQuery.allPosts(forUser: user))
            let rightBarButtonItem = BarButtonItem(image: UIImage(named: "Gear"), style: .plain, target: self, action: #selector(settingsButtonPressed))
            navigationItem.rightBarButtonItem = rightBarButtonItem
            viewModel?.queryComplete = { [weak self] Void in
                self?.removeActivityIndicator()
                if self?.viewModel?.numberOfPosts() == 0  {
                    self?.addEmptyView()
                }
            }
        } else {
            refreshControl = nil
            tableView.contentInset = UIEdgeInsets.zero
            tableView.bounces = false
            view.backgroundColor = Style.whiteColor
            navigationItem.title = "Profile"
            navigationItem.rightBarButtonItem = nil
            addSignedOutView()
        }
    }
    
    func setupActivityIndicator() {
        activity = UIActivityIndicatorView()
        activity?.color = Style.blueColor
        activity?.startAnimating()
        if let activity = activity {
            view.addSubview(activity)
            activity.autoCenterInSuperview()
        }
    }
    
    func removeActivityIndicator() {
        activity?.removeFromSuperview()
    }
    
    func addSignedOutView() {
        signedOutView = Bundle.main.loadNibNamed("SignedOutView", owner: self, options: nil)?.first as? SignedOutView
        if let signedOutView = signedOutView {
            signedOutView.alertLabel.text = "To manage your profile please"
            signedOutView.loginTapped = { [weak self] void in self?.showLogin() }
            signedOutView.signupTapped = { [weak self] void in self?.showSignup() }
            navigationController?.view.addSubview(signedOutView)
            signedOutView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsetsMake(64, 0, 49, 0))
        }
    }
    
    func addEmptyView() {
        emptyView = Bundle.main.loadNibNamed("ProfileEmptyView", owner: self, options: nil)?.first as? ProfileEmptyView
        if let emptyView = emptyView {
            emptyView.getStartedTapped = { [weak self] void in self?.showCamera() }
            navigationController?.view.addSubview(emptyView)
            emptyView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsetsMake(64, 0, 49, 0))
        }
    }
    
    func settingsButtonPressed() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileSettingsViewController") as? ProfileSettingsViewController {
            show(vc, sender: self)
        }
    }
    
    func showLogin() {
        Analytics.logEvent("Profile", action: "Login", Label: "Login Button Pressed", key: "")
        if let nc = Router.loginNavigationController() {
            present(nc, animated: true, completion: nil)
        }
    }
    
    func showSignup() {
        Analytics.logEvent("Profile", action: "Signup", Label: "Signup Button Pressed", key: "")
        if let nc = Router.signupNavigationController() {
            present(nc, animated: true, completion: nil)
        }
    }
    
    func showCamera() {
        Analytics.logEvent("Profile", action: "Get Started", Label: "Get Started Button Pressed", key: "")
        tabBarController?.selectedIndex = 1
    }
    
}
