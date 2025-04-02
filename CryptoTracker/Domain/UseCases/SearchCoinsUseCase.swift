//
//  SearchCoinsUseCase.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

protocol SearchCoinsUseCase {
    func execute(_ query: String) async throws -> [CoinAsset]
}

final class SearchCoinsUseCaseImpl: SearchCoinsUseCase {
    private let coinAssetsRepo: CoinAssetsRepository
    private let logger: LoggerProtocol
    
    init(coinAssetsRepo: CoinAssetsRepository, logger: LoggerProtocol) {
        self.coinAssetsRepo = coinAssetsRepo
        self.logger = logger
    }
    
    func execute(_ query: String) async throws -> [CoinAsset] {
        guard !query.isEmpty else {
            return try await coinAssetsRepo.fetchPopularCoins()
        }
        
        do {
            return try await coinAssetsRepo.fetchCoins(query)
        } catch {
            logger.debug(error.localizedDescription)
            // fallback to perform search among the popular coins
            let popularCoins = try await coinAssetsRepo.fetchPopularCoins()
            guard !popularCoins.isEmpty else {
                throw error
            }
            return popularCoins.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }
}
