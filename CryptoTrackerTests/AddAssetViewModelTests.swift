//
//  AddAssetViewModelTests.swift
//  CryptoTrackerTests
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker
import XCTest

// Examples how I write tests.
// Didn't cover everything to not spent too much time on the test task.

class AddAssetViewModelTests: XCTestCase {
    @MainActor
    func testForMemoryLeaks() {
        // GIVEN
        let sut = AddAssetViewModel(searchCoinsUseCase: SearchCoinsUseCaseFake(), addFavoriteCoinUseCase: AddFavoriteCoinUseCaseFake(), removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCaseFake())
        
        // THEN
        trackForMemoryLeaks(sut)
    }
}
