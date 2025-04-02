//
//  TestConfig.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import XCTest

final class TestConfig {
    static let shared = TestConfig()
    private init() {}
    
    private var application: XCUIApplication?
    public var getAppInstance: XCUIApplication {
        get {
            if let appValue = application {
                return appValue
            } else {
                return XCUIApplication()
            }
        }
        set(newValue) {
            application = newValue
        }
    }
}
