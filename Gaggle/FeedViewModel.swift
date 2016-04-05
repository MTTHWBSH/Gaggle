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
    
    var posts = []
    
    init(query: PFQuery) {
        super.init()
        loadData(withQuery: query)
    }
    
    func loadData(withQuery query: PFQuery) {
        query.findObjectsInBackgroundWithBlock { [weak self] (posts, error) in
            guard let posts = posts else { return }
            if error == nil {
                self?.posts = posts
                print(posts)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
}
