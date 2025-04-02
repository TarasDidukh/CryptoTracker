//
//  CoinAssetsServiceStub.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker



final class CoinAssetsServiceStub: CoinAssetsService {
    var fetchPopularCoinsCallback: (() throws -> [CoinAsset]) = { throw TestError.testingError }
    func fetchPopularCoins() async throws -> [CoinAsset] {
        try fetchPopularCoinsCallback()
    }
    
    var fetchCoinsCallback: ((String) throws -> [CoinAsset]) = { _ in throw TestError.testingError }
    func fetchCoins(_ searchQuery: String) async throws -> [CoinAsset] {
        try fetchCoinsCallback(searchQuery)
    }
    
    var fetchCoinsMarketDataCallback: (([String]) throws -> [CoinAsset]) = { _ in throw TestError.testingError }
    func fetchCoinsMarketData(for ids: [String]) async throws -> [CoinAsset] {
        try fetchCoinsMarketDataCallback(ids)
    }
}
