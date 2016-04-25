//
//  FeedViewModel.swift
//  Gaggle
//
//  Created by Matthew Bush on 3/20/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Foundation
import Parse

class FeedViewModel: NSObject {
    
    var render: (Void -> Void)? {
        didSet {
            render?()
        }
    }
    
    private var posts: [AnyObject]? {
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
                print(self?.posts)
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
        let imageFile = post?["image"] as! PFFile
        let subtitle = post?["subtitle"] as! String
        let title = post?["title"] as! String
        let userID = post?["userID"] as! String
        
        guard let image = imageFile.convertToImage() else { return nil }
        
        return Post(image: image, subtitle: subtitle, title: title, userID: userID)
    }
    
}
