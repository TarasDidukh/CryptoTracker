//
//  RealTimePriceUpdateUseCase.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import Foundation

protocol RealTimePriceUpdateUseCase {
    func execute(for coins: [CoinAsset], completion: @escaping ([CoinAsset]) -> Void) -> PriceUpdateInvalidation?
}

protocol PriceUpdateInvalidation {
    func invalidate()
}

extension Timer: PriceUpdateInvalidation {}

final class RealTimePriceUpdateUseCaseImpl: RealTimePriceUpdateUseCase {
    private let coinAssetsRepository: CoinAssetsRepository
    private var timer: Timer?
    private var completion: (([CoinAsset]) -> Void)?
    private var coins: [CoinAsset] = []
    
    init(coinAssetsRepository: CoinAssetsRepository) {
        self.coinAssetsRepository = coinAssetsRepository
    }
    
    func execute(for coins: [CoinAsset], completion: @escaping ([CoinAsset]) -> Void) -> PriceUpdateInvalidation? {
        timer?.invalidate()
        guard !coins.isEmpty else { return timer }
            
        self.completion = completion
        self.coins = coins
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(getLatestPrices), userInfo: nil, repeats: true)
        self.timer = timer
        return timer
    }
    
    @objc
    private func getLatestPrices() {
        guard let completion else {
            timer?.invalidate()
            return
        }
        Task {
            guard let updatedCoins = try? await coinAssetsRepository.fetchLatestPrices(for: coins) else {
                return
            }
            completion(updatedCoins)
        }
    }
}
