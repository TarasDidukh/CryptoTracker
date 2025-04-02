//
//  AddFavoriteCoinUseCase.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

protocol AddFavoriteCoinUseCase {
    func execute(_ coin: CoinAsset) async throws -> CoinAsset
}

final class AddFavoriteCoinUseCaseImpl: AddFavoriteCoinUseCase {
    private let favoriteCoinsRepository: FavoriteCoinsRepository
    
    init(favoriteCoinsRepository: FavoriteCoinsRepository) {
        self.favoriteCoinsRepository = favoriteCoinsRepository
    }
    
    func execute(_ coin: CoinAsset) async throws -> CoinAsset {
        try await favoriteCoinsRepository.add(coin)
    }
}
