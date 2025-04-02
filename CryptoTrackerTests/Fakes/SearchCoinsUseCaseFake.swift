//
//  SearchCoinsUseCaseFake.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker

final class SearchCoinsUseCaseFake: SearchCoinsUseCase {
    func execute(_ query: String) async throws -> [CoinAsset] {
        throw TestError.testingError
    }
}
