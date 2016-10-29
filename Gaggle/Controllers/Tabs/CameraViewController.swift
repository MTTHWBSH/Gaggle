 //
//  CameraViewController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit
import Parse
import AVFoundation
import PureLayout

class CameraViewController: ViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var previewView: UIView!
    @IBOutlet var cameraButtonBorderView: UIView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    
    @IBOutlet var previewViewTopMargin: NSLayoutConstraint!
    @IBOutlet var cameraButtonBorderWidth: NSLayoutConstraint!
    @IBOutlet var cameraButtonWidth: NSLayoutConstraint!
    @IBOutlet var confirmButtonWidth: NSLayoutConstraint!
    @IBOutlet var cancelButtonWidth: NSLayoutConstraint!
    
    let imagePicker = UIImagePickerController()
    
    var captureSession: AVCaptureSession?
    var image: AVCaptureStillImageOutput?
    var previewImage: UIImage?
    var imageToEdit: UIImage?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        styleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logScreen("Camera")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession?.stopRunning()
        previewLayer?.removeFromSuperlayer()
        removePreviewSubviews()
    }
    
    override func styleView() {
        if UIScreen.main.nativeBounds.height <= 960 {
            previewViewTopMargin.constant = 0
            cameraButtonBorderWidth.constant = 40
            cameraButtonWidth.constant = 32
            confirmButtonWidth.constant = 22
            cancelButtonWidth.constant = 22
        }
        
        cameraButtonBorderView.backgroundColor = UIColor.clear
        cameraButtonBorderView.layer.borderColor = Style.blueColor.cgColor
        cameraButtonBorderView.layer.borderWidth = 3.0
        cameraButtonBorderView.layer.cornerRadius = cameraButtonBorderView.frame.size.width / 2
        cameraButtonBorderView.clipsToBounds = true
        
        cameraButton.backgroundColor = Style.blueColor
        cameraButton.layer.cornerRadius = cameraButton.frame.size.width / 2
        cameraButton.clipsToBounds = true
        
        cancelButton.isHidden = true
        confirmButton.isHidden = true
        
        navigationItem.title = "Photo"
        view.backgroundColor = Style.whiteColor
    }
    
    func setup() {
        if Session.currentSession.loggedIn()  {
            
            guard let _ = PFUser.current() else { return }
            
            addCameraRollButton()
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) == .authorized {
                    showCameraElements()
                    
                    DispatchQueue.global().async {
                        self.setupCaptureSession()
                        DispatchQueue.main.async {
                            if let captureSession = self.captureSession {
                                self.addPreviewLayer(captureSession)
                            }
                        }
                    }
                } else if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) == .denied {
                    hideCameraElements()
                    showCameraDisabledLabel()
                } else {
                    hideCameraElements()
                    requestCameraAccess()
                }
            } else {
                hideCameraElements()
                showNoCameraLabel()
            }
            
        } else {
            hideCameraElements()
            showNoCameraLabel()
            addSignedOutView()
            
        }
    }
    
    func addSignedOutView() {
        guard let signedOutView = Bundle.main.loadNibNamed("SignedOutView", owner: self, options: nil)?.first as? SignedOutView else { return }
        signedOutView.alertLabel.text = "To create a post please"
        signedOutView.loginTapped = { [weak self] void in self?.showLogin() }
        signedOutView.signupTapped = { [weak self] void in self?.showSignup() }
        view.addSubview(signedOutView)
        signedOutView.autoPinEdgesToSuperviewEdges()
    }
    
    func requestCameraAccess() {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { [weak self] (granted :Bool) -> Void in
            DispatchQueue.main.async(execute: {
                self?.setup()
            })
        })
    }
    
    // MARK: UI Configuration
    
    func addCameraRollButton() {
        let rightBarButtonItem = BarButtonItem(image: UIImage(named: "CameraRoll"), style: .plain, target: self, action: #selector(showCameraRoll))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func showCameraRoll() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func hideCameraElements() {
        cameraButton.isHidden = true
        cameraButtonBorderView.isHidden = true
    }
    
    func showCameraElements() {
        cameraButton.isHidden = false
        cameraButtonBorderView.isHidden = false
        previewView.isHidden = false
    }
    
    func showCameraDisabledLabel() {
        let text = "Camera access must be enabled to use this feature.\n\n Go to settings to enable camera."
        showCenterLabelWithText(text)
    }
    
    func showNoCameraLabel() {
        let text = "This feature is only available on devices that support camera functions.\n\n Select a photo from your camera roll to get started."
        showCenterLabelWithText(text)
    }
    
    func showCenterLabelWithText(_ text: String) {
        let labelFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let label = UILabel(frame: labelFrame)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = Style.lightFontWithSize(20.0)
        label.textColor = Style.whiteColor
        label.text = text
        previewView.addSubview(label)
        
        label.autoPinEdgesToSuperviewEdges(with: UIEdgeInsetsMake(0.0, 20.0, 0.0, 20.0))
        label.autoCenterInSuperview()
    }
    
    func showActionButtons() {
        cancelButton.isHidden = false
        confirmButton.isHidden = false
        Animation.springAnimation(cancelButton, scale: 0.1, duration: 0.8, completion: nil)
        Animation.springAnimation(confirmButton, scale: 0.1, duration: 0.8, completion: nil)
    }
    
    func hideActionButtons() {
        cancelButton.isHidden = true
        confirmButton.isHidden = true
    }
    
    func removePreviewSubviews() {
        for view in previewView.subviews{
            view.removeFromSuperview()
        }
    }
    
    // MARK: AV Setup
    
    func setupCaptureSession() {
        captureSession = AVCaptureSession()
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
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
    
    func addPreviewLayer(_ captureSession: AVCaptureSession) {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        if let previewLayer = previewLayer {
            previewLayer.frame = previewView.bounds
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewView.layer.insertSublayer(previewLayer, above: previewView.layer)
        }
    }
    
    func cropToSquare(image originalImage: UIImage) -> UIImage? {
        guard let originalCGImage = originalImage.cgImage else { return nil }
        let contextImage = UIImage(cgImage: originalCGImage)
        let contextSize: CGSize = contextImage.size
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            width = contextSize.height
            height = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            width = contextSize.width
            height = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: width, height: height)
        guard let imageRef = contextImage.cgImage?.cropping(to: rect) else { return nil }
        let image = UIImage(cgImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        return image
    }
    
    func showPreview(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = previewView.bounds
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        removePreviewSubviews()
        previewView.insertSubview(imageView, aboveSubview: previewView)
        showActionButtons()
    }

    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismiss(animated: true) { [weak self] Void in
            self?.previewImage = image
            self?.showPreview(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditPost" {
            if let nc = segue.destination as? NavigationController, let vc = nc.topViewController as? EditPostViewController {
                if let preview = previewImage  {
                    let image = cropToSquare(image: preview)
                    vc.image = image
                }
            }
        }
    }
    
    // MARK: IBActions
    
    @IBAction func didPressCameraButton(_ sender: AnyObject) {
        Analytics.logEvent("Post", action: "Camera", Label: "Camera Button Pressed", key: "")
        Animation.springAnimation(cameraButton, scale: 0.8, duration: 1.5, completion: nil)
        
        guard let image = self.image else { return }
        
        if let videoConnection = image.connection(withMediaType: AVMediaTypeVideo) {
            image.captureStillImageAsynchronously(from: videoConnection, completionHandler: {(sampleBuffer, error) in
                
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                let dataProvider = CGDataProvider(data: imageData as! CFData)
                
                if let CGImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent) {
                    let image = UIImage(cgImage: CGImageRef, scale: 1.0, orientation: .up)
                    let rotatedImage = image.imageRotatedByDegrees(90, flip: false)
                    self.previewImage = rotatedImage
                    self.showPreview(rotatedImage)
                }
                
            })
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        Analytics.logEvent("Post", action: "Camera", Label: "Cancel Button Pressed", key: "")
        removePreviewSubviews()
        Animation.springAnimation(cancelButton, scale: 0.8, duration: 0.8) { [weak self] Void in
            self?.hideActionButtons()
        }
    }
    
    @IBAction func confirmButtonpressed(_ sender: AnyObject) {
        Analytics.logEvent("Post", action: "Camera", Label: "Confirm Button Pressed", key: "")
        Animation.springAnimation(confirmButton, scale: 0.8, duration: 0.8) { [weak self] Void in
            self?.performSegue(withIdentifier: "toEditPost", sender: self)
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
    
}
