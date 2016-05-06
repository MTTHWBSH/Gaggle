//
//  FeedQuery.swift
//  Gaggle
//
//  Created by Matthew Bush on 4/3/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Parse

class FeedQuery: NSObject {
    
    class func allPosts() -> PFQuery {
        let query = PFQuery(className:Constants.PostClassKey)
        query.orderByDescending("createdAt")
        return query
    }
    
    class func allPosts(forUser user: PFUser) -> PFQuery {
        let query = PFQuery(className:Constants.PostClassKey)
        if let userID = user.objectId {
           query.whereKey("userID", equalTo: userID)
        }
        query.orderByDescending("createdAt")
        return query
    }
    
}
