//
//  CoinAssetsService.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

protocol CoinAssetsService {
    func fetchPopularCoins() async throws -> [CoinAsset]
    func fetchCoins(_ searchQuery: String) async throws -> [CoinAsset]
    func fetchCoinsMarketData(for ids: [String]) async throws -> [CoinAsset]
}

final class CoinAssetsServiceImpl: CoinAssetsService {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchPopularCoins() async throws -> [CoinAsset] {
        let result: [CoinMarketDataDTO] = try await networkClient.get(RequestTypes.getTop100Coins)
        return result.map(CoinAsset.init)
    }
    
    func fetchCoins(_ searchQuery: String) async throws -> [CoinAsset] {
        let result: SearchCoinsResponseDTO = try await networkClient.get(RequestTypes.searchCoins(query: searchQuery.lowercased()))
        return result.coins.map(CoinAsset.init)
    }
    
    func fetchCoinsMarketData(for ids: [String]) async throws -> [CoinAsset] {
        guard !ids.isEmpty else { return [] }
        let result: [CoinMarketDataDTO] = try await networkClient.get(RequestTypes.getMarketData(ids: ids))
        return result.map(CoinAsset.init)
    }
}
