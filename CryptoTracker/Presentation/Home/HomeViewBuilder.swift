//
//  HomeViewBuilder.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import Foundation

struct HomeViewBuilder {
    @MainActor
    func build() -> HomeView {
        // This can be simplified with DI container
        let coinAssetsService = CoinAssetsServiceImpl(networkClient: NetworkClient.shared)
        let coinAssetsStorage = CoinAssetsStorageImpl(coreDataStack: CoreDataStack.shared)
        let keyValueStorage = UserDefaults.standard
        let favoriteCoinsRepository = FavoriteCoinsRepositoryImpl(coinAssetsStorage: coinAssetsStorage)
        let binanceAssetsService = BinanceAssetsServiceImpl(networkClient: NetworkClient.shared, quoteAsset: Constants.defaultQuoteCoin)
        let coinAssetsRepository = CoinAssetsRepositoryImpl(coinAssetsService: coinAssetsService, coinAssetsStorage: coinAssetsStorage, binanceAssetsService: binanceAssetsService, keyValueStorage: keyValueStorage)
        let viewFavoriteCoinsUseCase = ViewFavoriteCoinsUseCaseImpl(favoriteCoinsRepository: favoriteCoinsRepository)
        let removeFavoriteCoinUseCase = RemoveFavoriteCoinUseCaseImpl(favoriteCoinsRepository: favoriteCoinsRepository)
        let removeAllFavoriteCoinsUseCase = RemoveAllFavoriteCoinsUseCaseImpl(favoriteCoinsRepository: favoriteCoinsRepository)
        let viewLatestPriceUpdateDateUseCase = ViewLatestPriceUpdateDateUseCaseImpl(keyValueStorage: keyValueStorage)
        let realTimePriceUpdateUseCase = RealTimePriceUpdateUseCaseImpl(coinAssetsRepository: coinAssetsRepository)
        let viewModel = HomeViewModel(viewFavoriteCoinsUseCase: viewFavoriteCoinsUseCase, removeFavoriteCoinUseCase: removeFavoriteCoinUseCase, removeAllFavoriteCoinsUseCase: removeAllFavoriteCoinsUseCase, viewLatestPriceUpdateDateUseCase: viewLatestPriceUpdateDateUseCase, realTimePriceUpdateUseCase: realTimePriceUpdateUseCase)
        return HomeView(viewModel: viewModel)
    }
}
