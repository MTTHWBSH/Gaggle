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
    
    func setup() {
        navigationItem.title = "Photo"
        view.backgroundColor = Style.whiteColor
        if Session.currentSession.loggedIn()  {
            
            guard let _ = PFUser.currentUser() else { return }
            
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) ==  .Authorized {
                    showCameraElements()
                } else if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) == .Denied {
                    hideCameraElements()
                    showCameraDisabledState()
                } else {
                    hideCameraElements()
                    showEmptyState()
                    requestCameraAccess()
                }
            } else {
                hideCameraElements()
                showNoCameraLabel()
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
            dispatch_async(dispatch_get_main_queue(), {
                self?.setup()
            })
        })
    }
    
    func showEmptyState() {
        
    }
    
    func showCameraDisabledState() {
    
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
    
    func showNoCameraLabel() {
        let labelText = "This feature is only available on devices that support camera functions.\n\n Select a photo from your camera roll to get started."
        let labelFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let label = UILabel(frame: labelFrame)
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.font = Style.lightFontWithSize(20.0)
        label.textColor = Style.blackColor
        label.text = labelText
        view.addSubview(label)
        
        label.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0, 20.0, 0.0, 20.0))
        label.autoCenterInSuperview()
    }
    
    @IBAction func didPressCameraButton(sender: AnyObject) {
        Animation.springAnimation(cameraButton, scale: 0.8, duration: 1.5) { Void in
            // segue to next view with image
        }
    }
    
    
}