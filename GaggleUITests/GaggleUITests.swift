//
//  GaggleUITests.swift
//  GaggleUITests
//
//  Created by Matt Bush on 5/12/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import XCTest

class GaggleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        app.launchEnvironment = [ "UITest": "1" ]
        setupSnapshot(app)
        app.launch()
    }
    
    func testTakeScreenshots() {
        let app = XCUIApplication()
        
    }
    
}
