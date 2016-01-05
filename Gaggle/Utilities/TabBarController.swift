//
//  TabBarController.swift
//  Gaggle
//
//  Created by Matthew Bush on 1/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import UIKit
import MobileCoreServices

@objc protocol TabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, cameraButtonTouchUpInsideAction button: UIButton)
}

class TabBarController: UITabBarController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var navController: UINavigationController?
    
    // MARK:- UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleTabBar()
        
        navController = UINavigationController()
    }
    
    // MARK:- UITabBarController
    
    override func setViewControllers(viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        
        let cameraButton = UIButton(type: UIButtonType.Custom)
        cameraButton.frame = CGRectMake(94.0, 0.0, 131.0, self.tabBar.bounds.size.height)
        cameraButton.setImage(UIImage(named: "ButtonCamera.png"), forState: UIControlState.Normal)
        cameraButton.setImage(UIImage(named: "ButtonCameraSelected.png"), forState: UIControlState.Highlighted)
        cameraButton.addTarget(self, action: Selector("photoCaptureButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        tabBar.addSubview(cameraButton)
        
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("handleGesture:"))
        swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        swipeUpGestureRecognizer.numberOfTouchesRequired = 1
        cameraButton.addGestureRecognizer(swipeUpGestureRecognizer)
    }
    
    // MARK:- UIImagePickerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        self.dismissViewControllerAnimated(false, completion: nil)
//        
//        let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
//        
//        let viewController: PAPEditPhotoViewController = PAPEditPhotoViewController(image: image)
//        viewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
//        
//        self.navController!.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
//        self.navController!.pushViewController(viewController, animated: false)
//        
//        self.presentViewController(self.navController!, animated: true, completion: nil)
    }
    
    // MARK:- TabBarController
    
    func shouldPresentPhotoCaptureController() -> Bool {
        var presentedPhotoCaptureController: Bool = shouldStartCameraController()
        
        if !presentedPhotoCaptureController {
            presentedPhotoCaptureController = shouldStartPhotoLibraryPickerController()
        }
        
        return presentedPhotoCaptureController
    }
    
    // MARK:- ()
    
    func styleTabBar() {
        removeTabTitles()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.tintColor = Style.redColorSelectedTab
        tabBar.barTintColor = Style.whiteColor
        tabBar.translucent = false
        for tab in tabBar.items! {
            tab.image = tab.image?.imageWithRenderingMode(.AlwaysOriginal)
        }
    }
    
    func removeTabTitles() {
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
    }
    
    func photoCaptureButtonAction(sender: AnyObject) {
        let cameraDeviceAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        let photoLibraryAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        
        if cameraDeviceAvailable && photoLibraryAvailable {
            let actionController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let takePhotoAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartCameraController() })
            let choosePhotoAction = UIAlertAction(title: NSLocalizedString("Choose Photo", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartPhotoLibraryPickerController() })
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil)
            
            actionController.addAction(takePhotoAction)
            actionController.addAction(choosePhotoAction)
            actionController.addAction(cancelAction)
            
            presentViewController(actionController, animated: true, completion: nil)
        } else {
            // if we don't have at least two options, we automatically show whichever is available (camera or roll)
            shouldPresentPhotoCaptureController()
        }
    }
    
    func shouldStartCameraController() -> Bool {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
            return false
        }
        
        let cameraUI = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
            && UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)!.contains(kUTTypeImage as String) {
                
                cameraUI.mediaTypes = [kUTTypeImage as String]
                cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
                
                if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) {
                    cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Rear
                } else if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front) {
                    cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Front
                }
        } else {
            return false
        }
        
        cameraUI.allowsEditing = true
        cameraUI.showsCameraControls = true
        cameraUI.delegate = self
        
        presentViewController(cameraUI, animated: true, completion: nil)
        
        return true
    }
    
    
    func shouldStartPhotoLibraryPickerController() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == false
            && UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) == false {
                return false
        }
        
        let cameraUI = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
            && UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.PhotoLibrary)!.contains(kUTTypeImage as String) {
                
                cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                cameraUI.mediaTypes = [kUTTypeImage as String]
                
        } else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)
            && UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.SavedPhotosAlbum)!.contains(kUTTypeImage as String) {
                cameraUI.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                cameraUI.mediaTypes = [kUTTypeImage as String]
                
        } else {
            return false
        }
        
        cameraUI.allowsEditing = true
        cameraUI.delegate = self
        
        presentViewController(cameraUI, animated: true, completion: nil)
        
        return true
    }
    
    func handleGesture(gestureRecognizer: UIGestureRecognizer) {
        shouldPresentPhotoCaptureController()
    }
}
