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
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func numberOfPosts() -> Int {
        return posts?.count ?? 0
    }
    
    func postForIndexPath(indexPath: NSIndexPath) -> Post? {
        let post = posts?[indexPath.row]
        let imageFile = post?["image"] as? PFFile
        let subtitle = post?["subtitle"] as? String
        let title = post?["title"] as? String
        let userID = post?["userID"] as? String
        
        guard let timeString = post?.createdAt?.timeAgoSinceDate(true) else { return nil }
        let timeSince = timeSinceString(forDateString: " \(timeString)")
        var imageFromFile: UIImage?
        imageFile?.convertToImage({ image in
            imageFromFile = image
        })
        return Post(image: imageFromFile, subtitle: subtitle, title: title, timeSinceCreated: timeSince, userID: userID)
    }
    
    func userNameForID(userID id:String) -> String? {
        return id
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
