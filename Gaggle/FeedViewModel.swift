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
        let timeString = timeSinceCreated(timeCreated: post?.createdAt)
        var imageFromFile: UIImage?
        imageFile?.convertToImage({ image in
            imageFromFile = image
        })
        return Post(image: imageFromFile, subtitle: subtitle, title: title, timeSinceCreated: timeString, userID: userID)
    }
    
    func userNameForID(userID id:String) -> String? {
        return id
    }
    
    private func timeSinceCreated(timeCreated date:NSDate?) -> String {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        calendar.timeZone = NSTimeZone.systemTimeZone()
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = calendar.timeZone
        dateFormatter.dateFormat = "MMM d, yyyy"
        guard let date = date else { return "" }
        return dateFormatter.stringFromDate(date)
    }
    
}
