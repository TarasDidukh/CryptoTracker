//
//  RemoveAllFavoriteCoinsUseCase.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

protocol RemoveAllFavoriteCoinsUseCase {
    func execute() async throws
}

final class RemoveAllFavoriteCoinsUseCaseImpl: RemoveAllFavoriteCoinsUseCase {
    private let favoriteCoinsRepository: FavoriteCoinsRepository
    
    init(favoriteCoinsRepository: FavoriteCoinsRepository) {
        self.favoriteCoinsRepository = favoriteCoinsRepository
    }
    
    func execute() async throws {
        try await favoriteCoinsRepository.removeAll()
    }
}


