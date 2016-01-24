//
//  CameraViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit

class CameraViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        navigationItem.title = "Photo"
        view.backgroundColor = Style.whiteColor
        if Session.currentSession.loggedIn()  {
            guard let _ = PFUser.currentUser() else { return }
            if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) ==  AVAuthorizationStatus.Authorized {
                createCameraPreview()
            }
        } else {
            // show empty state
        }
    }
    
    func createCameraPreview() {

    }
    
    func requestCamera() {

    }
    
}