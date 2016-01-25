//
//  CameraViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: ViewController {
    
    @IBOutlet var previewView: UIView!
    @IBOutlet var cameraButtonBorderView: UIView!
    @IBOutlet var cameraButton: UIButton!
    
    var captureSession: AVCaptureSession?
    var image: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        styleView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    func setup() {
        navigationItem.title = "Photo"
        view.backgroundColor = Style.whiteColor
        if Session.currentSession.loggedIn()  {
            
            guard let _ = PFUser.currentUser() else { return }
            
            if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) ==  AVAuthorizationStatus.Authorized {
                showCameraElements()
            } else {
                hideCameraElements()
                showEmptyState()
                requestCameraAccess()
            }
        } else {
            showEmptyState()
        }
    }
    
    override func styleView() {
        cameraButtonBorderView.backgroundColor = UIColor.clearColor()
        cameraButtonBorderView.layer.borderColor = Style.redColor.CGColor
        cameraButtonBorderView.layer.borderWidth = 3.0
        cameraButtonBorderView.layer.cornerRadius = cameraButtonBorderView.frame.size.width / 2
        cameraButtonBorderView.clipsToBounds = true
        
        cameraButton.backgroundColor = Style.redColor
        cameraButton.layer.cornerRadius = cameraButton.frame.size.width / 2
        cameraButton.clipsToBounds = true
        
    }
    
    func createCameraPreview() {

    }
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { [weak self] (granted :Bool) -> Void in
            if granted == true {
                self?.showCameraElements()
            } else {
                self?.hideCameraElements()
                self?.showEmptyState()
            }
        })
    }
    
    func showEmptyState() {
        
    }
    
    func hideCameraElements() {
        cameraButton.hidden = true
        cameraButtonBorderView.hidden = true
        previewView.hidden = true
    }
    
    func showCameraElements() {
        cameraButton.hidden = false
        cameraButtonBorderView.hidden = false
        previewView.hidden = false
    }
    
    @IBAction func didPressCameraButton(sender: AnyObject) {
        Animation.springAnimation(cameraButton, scale: 0.8, duration: 1.5) { Void in
            print("completion called")
        }
    }
    
    
}