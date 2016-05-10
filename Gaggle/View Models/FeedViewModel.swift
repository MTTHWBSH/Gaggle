//
//  FeedViewModel.swift
//  Gaggle
//
//  Created by Matthew Bush on 3/20/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Foundation
import Parse
import SVProgressHUD

class FeedViewModel: NSObject {
    
    var queryComplete: (Void -> Void)?
    
    var render: (Void -> Void)? {
        didSet {
            render?()
        }
    }
    
    private var posts: [PFObject]? {
        didSet {
            render?()
        }
    }
    
    init(query: PFQuery) {
        super.init()
        loadData(withQuery: query)
    }
    
    func loadData(withQuery query: PFQuery) {
        query.findObjectsInBackgroundWithBlock { [weak self] (posts, error) in
            guard let posts = posts else { return }
            if error == nil {
                self?.posts = posts
                self?.render?()
                self?.queryComplete?()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func numberOfPosts() -> Int {
        return posts?.count ?? 0
    }
    
    func postForIndexPath(indexPath: NSIndexPath, completion: (Post -> Void)?) {
        let post = posts?[indexPath.row]
        let imageFile = post?["image"] as? PFFile
        let subtitle = post?["subtitle"] as? String
        let title = post?["title"] as? String
        let userID = post?["userID"] as? String
        
        guard let timeString = post?.createdAt?.timeAgoSinceDate(true) else { return }
        let timeSince = timeSinceString(forDateString: " \(timeString)")
        imageFile?.convertToImage({ image in
            let post = Post(image: image, subtitle: subtitle, title: title, timeSinceCreated: timeSince, userID: userID)
            completion?(post)
        })
    }
    
    func userForID(userID:String, completion: (PFUser -> Void)?) {
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo: userID)
        query?.findObjectsInBackgroundWithBlock { (users, error) in
            guard let user = users?.first as? PFUser else { return }
            completion?(user)
        }
    }
    
    private func timeSinceString(forDateString string: String) -> NSAttributedString? {
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: "Clock")
        guard let image = attachment.image else { return nil }
        attachment.bounds = CGRectMake(0, -3, image.size.width, image.size.height)
        
        let timeStringForDateString = NSMutableAttributedString()
        let attachmentString = NSAttributedString(attachment: attachment)
        let timeString = NSAttributedString(string: string)
        timeStringForDateString.appendAttributedString(attachmentString)
        timeStringForDateString.appendAttributedString(timeString)
        
        return timeStringForDateString
    }
    
}
