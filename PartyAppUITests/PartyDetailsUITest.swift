//
//  PartyDetailsUITest.swift
//  PartyAppUITests
//
//  Created by user1 on 20.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import XCTest

class PartyDetailsUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        sleep(6)
        let app = XCUIApplication()
        sleep(8)
        app.buttons["Party List"].tap()
        app.buttons["..."].tap()
        app.navigationBars["Party details (more)"].buttons["Party Details"].tap()
        app.navigationBars["Party Details"].buttons["Welcome"].tap()
        

        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
