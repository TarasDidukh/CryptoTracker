//
//  ViewFavoriteCoinsUseCase.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

protocol ViewFavoriteCoinsUseCase {
    func execute() async throws -> [CoinAsset]
}
    
final class ViewFavoriteCoinsUseCaseImpl: ViewFavoriteCoinsUseCase {
    private let favoriteCoinsRepository: FavoriteCoinsRepository
    
    init(favoriteCoinsRepository: FavoriteCoinsRepository) {
        self.favoriteCoinsRepository = favoriteCoinsRepository
    }
    
    func execute() async throws -> [CoinAsset] {
        try await favoriteCoinsRepository.fetchAll()
    }
}
