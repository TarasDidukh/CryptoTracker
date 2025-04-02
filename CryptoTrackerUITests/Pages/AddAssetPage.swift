//
//  AddAssetPage.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import XCTest

class AddAssetPage {
    private let app = TestConfig.shared.getAppInstance
    private let navigationBar: XCUIElement
    private let searchField: XCUIElement
    private let assetsList: XCUIElement
    
    required init() {
        navigationBar = app.navigationBars["Add Asset"]
        searchField = app.searchFields.firstMatch
        assetsList = app.collectionViews["AssetsList"]
    }
    
    func isDisplayed(timeout: TimeInterval = 5) -> Bool {
        navigationBar.exists && searchField.exists && assetsList.waitForExistence(timeout: timeout)
    }
    
    // MARK: - Actions
    
    func addFirstFavoriteAsset() -> String {
        let firstCell = assetsList.cells.firstMatch
        let symbolText = firstCell.staticTexts["SymbolLabel"].label
        let starButton = firstCell.buttons["StarButton"]
        starButton.tap()
        return symbolText
    }
    
    func tapBack() {
        navigationBar.buttons.element(boundBy: 0).tap()
    }
}
