//
//  CoinAssetsStorage.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import CoreData

protocol CoinAssetsStorage {
    func fetchPopularCoins() async throws -> [CoinAsset]
    func saveCoins(_ coins: [CoinAsset]) async throws
    func fetchFavoriteCoins() async throws -> [CoinAsset]
    func setFavorite(_ coin: CoinAsset, isFavorite: Bool) async throws -> CoinAsset
    func removeAllFavoriteCoins() async throws
}

final class CoinAssetsStorageImpl: CoinAssetsStorage {
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func fetchPopularCoins() async throws -> [CoinAsset] {
        try await coreDataStack.performBackgroundTask { context in
            let request = CoinAssetEntity.fetchRequest()
            request.predicate = NSPredicate(format: "marketCapRank <= 100")
            request.sortDescriptors = [NSSortDescriptor(keyPath: \CoinAssetEntity.marketCapRank, ascending: true)]
            let result = try context.fetch(request)
            return result.compactMap(CoinAsset.init)
        }
    }
    
    func saveCoins(_ coins: [CoinAsset]) async throws {
        try await coreDataStack.performBackgroundTask { context in
            let request = CoinAssetEntity.fetchRequest()
            let result = try context.fetch(request)
            coins.forEach { coin in
                let entity = result.first(where: { $0.id == coin.id }) ?? CoinAssetEntity(context: context)
                entity.copy(from: coin)
            }
            try context.save()
        }
    }
    
    func fetchFavoriteCoins() async throws -> [CoinAsset] {
        try await coreDataStack.performBackgroundTask { context in
            let request = CoinAssetEntity.fetchRequest()
            request.predicate = NSPredicate(format: "isFavorite == TRUE")
            request.sortDescriptors = [NSSortDescriptor(keyPath: \CoinAssetEntity.marketCapRank, ascending: true)]
            let result = try context.fetch(request)
            return result.compactMap(CoinAsset.init)
        }
    }
    
    func setFavorite(_ coin: CoinAsset, isFavorite: Bool) async throws -> CoinAsset {
        try await coreDataStack.performBackgroundTask { context in
            let request = CoinAssetEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id ==  %@", coin.id)
            request.fetchLimit = 1
            let coinEntity = try context.fetch(request).first ?? CoinAssetEntity(context: context)
            
            var coin = coin
            coin.isFavorite = isFavorite
            coinEntity.copy(from: coin)
            coinEntity.isFavorite = isFavorite
            try context.save()
            return coin
        }
    }
    
    func removeAllFavoriteCoins() async throws {
        try await coreDataStack.performBackgroundTask { context in
            let request = CoinAssetEntity.fetchRequest()
            request.predicate = NSPredicate(format: "isFavorite == TRUE")
            let result = try context.fetch(request)
            result.forEach { coin in
                coin.isFavorite = false
            }
            try context.save()
        }
    }
}

