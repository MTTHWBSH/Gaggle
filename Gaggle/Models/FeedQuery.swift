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
        return PFQuery(className:Constants.PostClassKey)
    }
    
}
