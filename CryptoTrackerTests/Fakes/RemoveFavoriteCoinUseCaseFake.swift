//
//  RemoveFavoriteCoinUseCaseFake.swift
//  CryptoTrackerTests
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker

final class RemoveFavoriteCoinUseCaseFake: RemoveFavoriteCoinUseCase {
    func execute(_ coin: CoinAsset) async throws -> CoinAsset {
        throw TestError.testingError
    }
}
