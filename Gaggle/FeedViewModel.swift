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
    
    var query: PFQuery {
        didSet {
            loadData(withQuery: query)
        }
    }
    
    init(query: PFQuery) {
        super.init()
        loadData(withQuery: query)
    }
    
    func loadData(withQuery query: PFQuery) {

    }
    
    func numberOfPosts() -> Int {
        return 1
    }
    
}
