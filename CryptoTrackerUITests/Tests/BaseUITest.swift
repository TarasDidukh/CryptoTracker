//
//  BaseUITest.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import XCTest

class BaseUITest: XCTestCase {
    var app = TestConfig.shared.getAppInstance
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app.activate()
    }
}

