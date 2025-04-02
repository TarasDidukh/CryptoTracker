//
//  BinanceAssetsService.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import Foundation

protocol BinanceAssetsService {
    func fetchLatestPrices(for coins: [CoinAsset]) async throws -> [CoinAsset]
    func fetchSupportedCoins() async throws -> [String]
}

final class BinanceAssetsServiceImpl: BinanceAssetsService {
    private let networkClient: NetworkClientProtocol
    private let quoteAsset: String
    
    init(networkClient: NetworkClientProtocol, quoteAsset: String) {
        self.networkClient = networkClient
        self.quoteAsset = quoteAsset.uppercased()
    }
    
    func fetchLatestPrices(for coins: [CoinAsset]) async throws -> [CoinAsset] {
        guard !coins.isEmpty else { return [] }
        let symbols = coins.map { $0.symbol.uppercased() + quoteAsset }
        let latestPrices: [SymbolLatestPriceDTO] = try await networkClient.get(RequestTypes.tickersPrice(symbols: symbols))
        return coins.enumerated().map { index, coin in
            if let latestPrice = latestPrices.first(where: { $0.symbol == coin.symbol.uppercased() + quoteAsset }) {
                return coin.updated(with: latestPrice)
            }
            return coin
        }
    }
    
    func fetchSupportedCoins() async throws -> [String] {
        let result: ExchageInfoDTO = try await networkClient.get(RequestTypes.exchangeInfo)
        return result.symbols.filter { $0.quoteAsset == quoteAsset }.map(\.baseAsset)
    }
}
