//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    private let formatterProvider = NumberFormatterProvider()
    private let viewFavoriteCoinsUseCase: ViewFavoriteCoinsUseCase
    private let removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCase
    private let removeAllFavoriteCoinsUseCase: RemoveAllFavoriteCoinsUseCase
    private let viewLatestPriceUpdateDateUseCase: ViewLatestPriceUpdateDateUseCase
    private let realTimePriceUpdateUseCase: RealTimePriceUpdateUseCase
    
    private var priceUpdateInvalidation: PriceUpdateInvalidation?
    
    private(set) var errorModel: ErrorModel? {
        didSet {
            isErrorPresented = errorModel != nil
        }
    }
    var percentageFormatter: NumberFormatter { formatterProvider.percentageFormatter }
    @Published var isErrorPresented: Bool = false
    @Published var isAddAssetPresenting = false
    @Published var favoriteCoins: [FavoriteAssetItemViewModel] = []
    @Published var latestUpdateDateFormatted: String = ""
    
    init(
        viewFavoriteCoinsUseCase: ViewFavoriteCoinsUseCase,
        removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCase,
        removeAllFavoriteCoinsUseCase: RemoveAllFavoriteCoinsUseCase,
        viewLatestPriceUpdateDateUseCase: ViewLatestPriceUpdateDateUseCase,
        realTimePriceUpdateUseCase: RealTimePriceUpdateUseCase
    ) {
        self.viewFavoriteCoinsUseCase = viewFavoriteCoinsUseCase
        self.removeFavoriteCoinUseCase = removeFavoriteCoinUseCase
        self.removeAllFavoriteCoinsUseCase = removeAllFavoriteCoinsUseCase
        self.viewLatestPriceUpdateDateUseCase = viewLatestPriceUpdateDateUseCase
        self.realTimePriceUpdateUseCase = realTimePriceUpdateUseCase
    }
    
    // MARK: - Public methods
    
    func addButtonTapped() {
        isAddAssetPresenting = true
    }
    
    func swipeToDelete(at indexSet: IndexSet) async {
        guard let selectedCoin = indexSet.first.map({ favoriteCoins[$0] }) else { return }
        do {
            _ = try await removeFavoriteCoinUseCase.execute(selectedCoin.model)
            favoriteCoins.remove(atOffsets: indexSet)
            startRealTimePriceUpdate()
        } catch {
            errorModel = ErrorModel(error: error)
        }
    }
    
    func trashButtonTapped() async {
        do {
            try await removeAllFavoriteCoinsUseCase.execute()
            favoriteCoins = []
            priceUpdateInvalidation?.invalidate()
        } catch {
            errorModel = ErrorModel(error: error)
        }
    }
    
    func viewTask() async {
        await updateFavoriteCoins()
        updateLatestDateMessage()
        startRealTimePriceUpdate()
    }
    
    func onDisappear() {
        priceUpdateInvalidation?.invalidate()
    }
    
    func getFormatter(for price: Decimal) -> NumberFormatter {
        formatterProvider.getFormatter(for: price)
    }
}

// MARK: - Private methods

private extension HomeViewModel {
    func updateFavoriteCoins() async {
        do {
            let favoriteCoins = try await viewFavoriteCoinsUseCase.execute()
            self.favoriteCoins = favoriteCoins.map(FavoriteAssetItemViewModel.init)
        } catch {
            errorModel = ErrorModel(error: error)
        }
    }
    
    func updateLatestDateMessage() {
        let date = viewLatestPriceUpdateDateUseCase.execute()
        latestUpdateDateFormatted = date?.timeAgoDisplay() ?? "Unknown"
    }
    
    func startRealTimePriceUpdate() {
        priceUpdateInvalidation = realTimePriceUpdateUseCase.execute(for: favoriteCoins.map(\.model)) { [weak self] result in
            Task { @MainActor in
                self?.mergeRealTimePrices(result)
            }
        }
    }
    
    
    func mergeRealTimePrices(_ coins: [CoinAsset]) {
        favoriteCoins.forEach { viewModel in
            if let newCoin = coins.first(where: { viewModel.model.id == $0.id }) {
                viewModel.update(with: newCoin)
            }
        }
        updateLatestDateMessage()
    }
}
