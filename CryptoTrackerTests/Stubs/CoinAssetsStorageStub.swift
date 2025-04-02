//
//  CoinAssetsStorageStub.swift
//  CryptoTrackerTests
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker

final class CoinAssetsStorageStub: CoinAssetsStorage {
    var saveCoinsCallback: (([CoinAsset]) throws -> Void) = { _ in throw TestError.testingError }
    func saveCoins(_ coins: [CoinAsset]) async throws {
        try saveCoinsCallback(coins)
    }

    var fetchPopularCoinsCallback: (() throws -> [CoinAsset]) = { throw TestError.testingError }
    func fetchPopularCoins() async throws -> [CoinAsset] {
        try fetchPopularCoinsCallback()
    }
    
    var fetchFavoriteCoinsCallback: (() throws -> [CoinAsset]) = { throw TestError.testingError }
    func fetchFavoriteCoins() async throws -> [CoinAsset] {
        try fetchFavoriteCoinsCallback()
    }
    
    var setFavoriteCallback: ((CoinAsset, Bool) throws -> CoinAsset) = { _, _ in throw TestError.testingError }
    func setFavorite(_ coin: CoinAsset, isFavorite: Bool) async throws -> CoinAsset {
        try setFavoriteCallback(coin, isFavorite)
    }
    
    var removeAllFavoriteCoinsCallback: (() throws -> Void) = { throw TestError.testingError }
    func removeAllFavoriteCoins() async throws {
        try removeAllFavoriteCoinsCallback()
    }
}
