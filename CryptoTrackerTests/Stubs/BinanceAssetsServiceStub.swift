//
//  BinanceAssetsServiceStub.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker

final class BinanceAssetsServiceStub: BinanceAssetsService {
    var fetchLatestPricesCallback: (([CoinAsset]) throws -> [CoinAsset]) = { _ in throw TestError.testingError}
    func fetchLatestPrices(for coins: [CoinAsset]) async throws -> [CoinAsset] {
        try fetchLatestPricesCallback(coins)
    }
    
    var fetchSupportedCoinsCallback: (() throws -> [String]) = { throw TestError.testingError}
    func fetchSupportedCoins() async throws -> [String] {
        try fetchSupportedCoinsCallback()
    }
}
