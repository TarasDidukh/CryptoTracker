//
//  FavoriteCoinsRepository.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

protocol FavoriteCoinsRepository {
    func fetchAll() async throws -> [CoinAsset]
    func add(_ coin: CoinAsset) async throws -> CoinAsset
    func remove(_ coin: CoinAsset) async throws -> CoinAsset
    func removeAll() async throws
}

final class FavoriteCoinsRepositoryImpl: FavoriteCoinsRepository {
    private let coinAssetsStorage: CoinAssetsStorage
    
    init(coinAssetsStorage: CoinAssetsStorage) {
        self.coinAssetsStorage = coinAssetsStorage
    }
    
    func fetchAll() async throws -> [CoinAsset] {
        try await coinAssetsStorage.fetchFavoriteCoins()
    }
    
    func add(_ coin: CoinAsset) async throws -> CoinAsset {
        try await coinAssetsStorage.setFavorite(coin, isFavorite: true)
    }
    
    func remove(_ coin: CoinAsset) async throws -> CoinAsset {
        try await coinAssetsStorage.setFavorite(coin, isFavorite: false)
    }
    
    func removeAll() async throws {
        try await coinAssetsStorage.removeAllFavoriteCoins()
    }
}
