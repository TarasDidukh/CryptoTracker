//
//  CoinAssetsRepository.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import Foundation

protocol CoinAssetsRepository {
    func fetchPopularCoins() async throws -> [CoinAsset]
    func fetchCoins(_ searchQuery: String) async throws -> [CoinAsset]
    func fetchLatestPrices(for coins: [CoinAsset]) async throws -> [CoinAsset]
}

final class CoinAssetsRepositoryImpl: CoinAssetsRepository {
    private let coinAssetsService: CoinAssetsService
    private let coinAssetsStorage: CoinAssetsStorage
    private let binanceAssetsService: BinanceAssetsService
    private let keyValueStorage: KeyValueStorage
    
    init(
        coinAssetsService: CoinAssetsService,
        coinAssetsStorage: CoinAssetsStorage,
        binanceAssetsService: BinanceAssetsService,
        keyValueStorage: KeyValueStorage
    ) {
        self.coinAssetsService = coinAssetsService
        self.coinAssetsStorage = coinAssetsStorage
        self.binanceAssetsService = binanceAssetsService
        self.keyValueStorage = keyValueStorage
    }
    
    func fetchPopularCoins() async throws -> [CoinAsset] {
        do {
            let result = try await coinAssetsService.fetchPopularCoins()
            if result.isEmpty {
                return try await coinAssetsStorage.fetchPopularCoins()
            } else {
                // no need to handle this error
                async let _ = coinAssetsStorage.saveCoins(result)
                return await fillFavoriteCoins(for: result)
            }
        } catch {
            return try await coinAssetsStorage.fetchPopularCoins()
        }
    }
    
    func fetchCoins(_ searchQuery: String) async throws -> [CoinAsset] {
        let coins = try await coinAssetsService.fetchCoins(searchQuery)
        return await fillFavoriteCoins(for: coins)
    }
    
    func fetchLatestPrices(for coins: [CoinAsset]) async throws -> [CoinAsset] {
        // It can be refactored to use less code or split into smaller functions
        // for now leaving this working version
        let supportedCoins = keyValueStorage.string(forKey: Constants.Keys.binanceSupportedCoins) ?? ""
        let binanceSymbols = supportedCoins.split(separator: ",").map(String.init)
        
        var binanceCoins = [CoinAsset]()
        var otherCoins = [CoinAsset]()
        
        for coin in coins {
            if binanceSymbols.contains(coin.symbol.uppercased()) {
                binanceCoins.append(coin)
            } else {
                otherCoins.append(coin)
            }
        }
        var ids = otherCoins.map(\.id)
        
        do {
            binanceCoins = try await binanceAssetsService.fetchLatestPrices(for: binanceCoins)
        } catch {
            // if binance fails to provide latest prices, we use another service
            ids += binanceCoins.map(\.id)
            let result = try await coinAssetsService.fetchCoinsMarketData(for: ids)
            try? await coinAssetsStorage.saveCoins(result)
            keyValueStorage.setValue(Date(), forKey: Constants.Keys.latestPriceUpdateDate)
            return result
        }
        // some coins are not supported by binance, so we fetch them from another service
        otherCoins = (try? await coinAssetsService.fetchCoinsMarketData(for: ids)) ?? otherCoins
        let result = otherCoins + binanceCoins
        try? await coinAssetsStorage.saveCoins(result)
        keyValueStorage.setValue(Date(), forKey: Constants.Keys.latestPriceUpdateDate)
        return result
    }
    
    private func fillFavoriteCoins(for coins: [CoinAsset]) async -> [CoinAsset] {
        guard let cachedCoins = try? await coinAssetsStorage.fetchFavoriteCoins() else { return coins }
        
        return coins.map { coin in
            var coin = coin
            if cachedCoins.contains(where: { $0.id == coin.id && $0.isFavorite }) {
                coin.isFavorite = true
            }
            return coin
        }
    }
}
