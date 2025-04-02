//
//  AddAssetViewBuilder.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import Foundation

struct AddAssetViewBuilder {
    @MainActor
    func build() -> AddAssetView {
        // This can be simplified with DI container
        let coinAssetsService = CoinAssetsServiceImpl(networkClient: NetworkClient.shared)
        let coinAssetsStorage = CoinAssetsStorageImpl(coreDataStack: CoreDataStack.shared)
        let keyValueStorage = UserDefaults.standard
        let binanceAssetsService = BinanceAssetsServiceImpl(networkClient: NetworkClient.shared, quoteAsset: Constants.defaultQuoteCoin)
        let coinAssetsRepository = CoinAssetsRepositoryImpl(coinAssetsService: coinAssetsService, coinAssetsStorage: coinAssetsStorage, binanceAssetsService: binanceAssetsService, keyValueStorage: keyValueStorage)
        let searchCoinsUseCase = SearchCoinsUseCaseImpl(coinAssetsRepo: coinAssetsRepository, logger: OSLogger.shared)
        let favoriteCoinsRepository = FavoriteCoinsRepositoryImpl(coinAssetsStorage: coinAssetsStorage)
        let addFavoriteCoinUseCase = AddFavoriteCoinUseCaseImpl(favoriteCoinsRepository: favoriteCoinsRepository)
        let removeFavoriteCoinUseCase = RemoveFavoriteCoinUseCaseImpl(favoriteCoinsRepository: favoriteCoinsRepository)
        let viewModel = AddAssetViewModel(searchCoinsUseCase: searchCoinsUseCase, addFavoriteCoinUseCase: addFavoriteCoinUseCase, removeFavoriteCoinUseCase: removeFavoriteCoinUseCase)
        return AddAssetView(viewModel: viewModel)
    }
}
