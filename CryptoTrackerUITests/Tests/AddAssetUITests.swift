
//
//  AddAssetUITests.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import XCTest

class AddAssetUITests: BaseUITest {
    let homePage = HomePage()
    let addAssetPage = AddAssetPage()
    
    func testAddFavoriteCoin() {
        // GIVEN
        XCTAssertTrue(homePage.isDisplayed())
        homePage.tapDeleteAssetsButton()
        XCTAssertTrue(homePage.isNoAssetsDisplayed())
        homePage.tapAddAssetsButton()
        XCTAssertTrue( addAssetPage.isDisplayed())
        
        // WHEN
        let symbolName = addAssetPage.addFirstFavoriteAsset()
        
        // THEN
        addAssetPage.tapBack()
        XCTAssertTrue(homePage.isSymbolDisplayed(symbol: symbolName))
    }
    
    func testFavoriteCoinsSavedBetweenAppSessions() {
        // GIVEN
        testAddFavoriteCoin()
        let symbolName = homePage.getFirstSymbolName()
        
        // WHEN
        app.terminate()
        app.activate()
        
        // THEN
        XCTAssertTrue(homePage.isSymbolDisplayed(symbol: symbolName))
    }
}
