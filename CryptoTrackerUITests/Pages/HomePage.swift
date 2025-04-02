//
//  HomePage.swift
//  CryptoTrackerUITests
//
//  Created by Taras Didukh on 02.04.2025.
//

import XCTest

class HomePage {
    private let app = TestConfig.shared.getAppInstance
    private let exchangeRateTitle: XCUIElement
    private let addAssetsButton: XCUIElement
    private let deleteAssetsButton: XCUIElement
    private let noAssetsAddedLabel: XCUIElement
    
    required init() {
        exchangeRateTitle = app.navigationBars["Exchange Rates"]
        addAssetsButton = app.buttons["AddAssetButton"]
        deleteAssetsButton = app.buttons["DeleteAssetsButton"]
        
        noAssetsAddedLabel = app.staticTexts["NoAssetsAdded"]
    }
    
    func isDisplayed(timeout: TimeInterval = 3) -> Bool {
        exchangeRateTitle.waitForExistence(timeout: timeout) && addAssetsButton.exists && deleteAssetsButton.exists
    }
    
    func isNoAssetsDisplayed() -> Bool {
        noAssetsAddedLabel.exists
    }
    
    func isSymbolDisplayed(symbol: String, timeout: TimeInterval = 1) -> Bool {
        let symbolLabel = app.collectionViews.staticTexts["SymbolLabel"].firstMatch
        guard symbolLabel.waitForExistence(timeout: timeout) else {
            return false
        }
        return symbolLabel.label == symbol
    }
    
    func getFirstSymbolName() -> String {
        app.collectionViews.staticTexts["SymbolLabel"].firstMatch.label
    }
    
    // MARK: - Actions
    
    func tapDeleteAssetsButton() {
        deleteAssetsButton.tap()
    }
    
    func tapAddAssetsButton() {
        addAssetsButton.tap()
    }
}
