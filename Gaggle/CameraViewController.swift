//
//  CameraViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class CameraViewController: ViewController {
    
    @IBOutlet var previewView: UIView!
    @IBOutlet var cameraButtonBorderView: UIView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    
    var captureSession: AVCaptureSession?
    var image: AVCaptureStillImageOutput?
    var previewImage: UIImage?
    var imageToEdit: UIImage?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        styleView()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession?.stopRunning()
        previewLayer?.removeFromSuperlayer()
        for view in previewView.subviews{
            view.removeFromSuperview()
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
        
        cancelButton.hidden = true
        confirmButton.hidden = true
        
        navigationItem.title = "Photo"
        view.backgroundColor = Style.whiteColor
    }
    
    func setup() {
        if Session.currentSession.loggedIn()  {
            
            guard let _ = PFUser.currentUser() else { return }
            
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) == .Authorized {
                    showCameraElements()
                    
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        self.setupCaptureSession()
                        dispatch_async(dispatch_get_main_queue()) {
                            if let captureSession = self.captureSession {
                                self.addPreviewLayer(captureSession)
                            }
                        }
                    }
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
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { [weak self] (granted :Bool) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self?.setup()
            })
            })
    }
    
    // MARK: UI Configuration
    
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
    
    func showCameraDisabledState() {
        let text = "Camera access must be enabled to use this feature.\n\n Go to settings to enable camera."
        showCenterLabelWithText(text)
    }
    
    func showNoCameraLabel() {
        let text = "This feature is only available on devices that support camera functions.\n\n Select a photo from your camera roll to get started."
        showCenterLabelWithText(text)
    }
    
    func showCenterLabelWithText(text: String) {
        let labelFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let label = UILabel(frame: labelFrame)
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.font = Style.lightFontWithSize(20.0)
        label.textColor = Style.blackColor
        label.text = text
        view.addSubview(label)
        
        label.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0.0, 20.0, 0.0, 20.0))
        label.autoCenterInSuperview()
    }
    
    func showActionButtons () {
        cancelButton.hidden = false
        confirmButton.hidden = false
        Animation.springAnimation(cancelButton, scale: 1.8, duration: 1.2, completion: nil)
        Animation.springAnimation(confirmButton, scale: 1.8, duration: 1.2, completion: nil)
    }
    
    // MARK: AV Setup
    
    func setupCaptureSession() {
        captureSession = AVCaptureSession()
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let input: AVCaptureDeviceInput?
        
        guard let captureSession = captureSession else { return }
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
        } catch _ {
            fatalError("Error setting up capture session")
        }
        
        image = AVCaptureStillImageOutput()
        guard let image = image else { return }
        image.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        captureSession.addOutput(image)
        captureSession.startRunning()
    }
    
    func addPreviewLayer(captureSession: AVCaptureSession) {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        if let previewLayer = previewLayer {
            previewLayer.frame = previewView.bounds
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewView.layer.insertSublayer(previewLayer, above: previewView.layer)
        }
    }
    
    func croppedImageToEdit(image: UIImage) -> UIImage {
        let rect = CGRectMake(previewView.bounds.minX, previewView.bounds.minY, previewView.bounds.width, previewView.bounds.height)
        guard let imageRef = CGImageCreateWithImageInRect(image.CGImage, rect) else { return image }
        let croppedImage = UIImage(CGImage: imageRef)
        
        return croppedImage
    }
    
    func showPreview(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = previewView.bounds
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        previewView.insertSubview(imageView, aboveSubview: previewView)
        showActionButtons()
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEditPost" {
            let nc = segue.destinationViewController as! NavigationController
            if let vc = nc.topViewController as? EditPostViewController {
                if let preview = previewImage  {
                    let image = croppedImageToEdit(preview)
                    vc.image = image
                    print(vc.image)
                    performSegueWithIdentifier("toEditPost", sender: self)
                }
            }
        }
    }
    
    // MARK: IBActions
    
    @IBAction func didPressCameraButton(sender: AnyObject) {
        Animation.springAnimation(cameraButton, scale: 0.8, duration: 1.5, completion: nil)
        
        guard let image = self.image else { return }
        
        if let videoConnection = image.connectionWithMediaType(AVMediaTypeVideo) {
            image.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {(sampleBuffer, error) in
                
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                let dataProvider = CGDataProviderCreateWithCFData(imageData)
                
                if let CGImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, .RenderingIntentDefault) {
                    let image = UIImage(CGImage: CGImageRef, scale: 1.0, orientation: .Right)
                    self.previewImage = image
                    self.showPreview(image)
                }
                
            })
        }
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        Animation.springAnimation(cancelButton, scale: 1.2, duration: 1.2, completion: nil)
        for view in self.previewView.subviews {
            view.removeFromSuperview()
        }
    }
    
    @IBAction func confirmButtonpressed(sender: AnyObject) {
        Animation.springAnimation(confirmButton, scale: 1.2, duration: 1.2) { [weak self] Void in
            self?.performSegueWithIdentifier("toEditPost", sender: self)
        }
    }
    
    
    
}