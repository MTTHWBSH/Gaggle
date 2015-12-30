//
//  Session.swift
//  Gaggle
//
//  Created by Matt Bush on 12/29/15.
//  Copyright © 2015 Matthew Bush. All rights reserved.
//

import Foundation

class Session {

    class var currentSession : Session {
        struct Static {
            static let instance : Session = Session()
        }
        return Static.instance
    }
    
    func loggedIn() -> Bool {
        return PFUser.currentUser() != nil
    }

}
