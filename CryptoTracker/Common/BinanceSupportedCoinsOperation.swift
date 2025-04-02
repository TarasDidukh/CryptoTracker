//
//  BinanceSupport.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import Foundation

final class BinanceSupportedCoinsOperation {
    static let shared = BinanceSupportedCoinsOperation()
    private let binanceService: BinanceAssetsService = BinanceAssetsServiceImpl(networkClient: NetworkClient.shared, quoteAsset: Constants.defaultQuoteCoin)
    private let keyValueStorage: KeyValueStorage = UserDefaults.standard
    private var isExecuted = false
    
    private init() {}
    
    func fethAndCacheSupportedCoins() {
        guard !isExecuted else {
            return
        }
        Task {
            let coins = try await binanceService.fetchSupportedCoins()
            isExecuted = true
            keyValueStorage.setValue(coins.joined(separator: ","), forKey: Constants.Keys.binanceSupportedCoins)
        }
    }
}
    
