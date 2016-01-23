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
            if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) ==  AVAuthorizationStatus.Authorized
            {
                createCameraPreview()
            }
            createCameraPreview()
        } else {
            // show empty state
        }
    }
    
    func createCameraPreview() {
        let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        let cameraPreviewRect: CGRect = CGRectMake(0.0, 0.0, screenWidth, screenWidth)
        let camera = LLSimpleCamera(quality: AVCaptureSessionPresetHigh, position: LLCameraPositionRear, videoEnabled: false)
        
        camera.attachToViewController(self, withFrame: cameraPreviewRect)
    }
    
    func requestCamera() {
        LLSimpleCamera.requestCameraPermission { Void in
            // do some stuff
        }
    }
    
}