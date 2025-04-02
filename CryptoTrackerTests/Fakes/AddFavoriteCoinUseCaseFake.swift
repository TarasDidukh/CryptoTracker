//
//  AddFavoriteCoinUseCaseFake.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker

final class AddFavoriteCoinUseCaseFake: AddFavoriteCoinUseCase {
    func execute(_ coin: CoinAsset) async throws -> CoinAsset {
        throw TestError.testingError
    }
}
