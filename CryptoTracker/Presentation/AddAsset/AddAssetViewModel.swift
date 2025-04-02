//
//  AddAssetViewModel.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import SwiftUI
import Combine

@MainActor
final class AddAssetViewModel: ObservableObject {
    private var bag = Set<AnyCancellable>()
    
    private let searchCoinsUseCase: SearchCoinsUseCase
    private let addFavoriteCoinUseCase: AddFavoriteCoinUseCase
    private let removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCase
    
    private(set) var errorModel: ErrorModel? {
        didSet {
            isErrorPresented = errorModel != nil
        }
    }
    @Published var isErrorPresented: Bool = false
    @Published var isLoading: Bool = false
    
    @Published var searchQuery: String = ""
    @Published var coins: [AddAssetItemViewModel] = []
    
    init(
        searchCoinsUseCase: SearchCoinsUseCase,
        addFavoriteCoinUseCase: AddFavoriteCoinUseCase,
        removeFavoriteCoinUseCase: RemoveFavoriteCoinUseCase
    ) {
        self.searchCoinsUseCase = searchCoinsUseCase
        self.addFavoriteCoinUseCase = addFavoriteCoinUseCase
        self.removeFavoriteCoinUseCase = removeFavoriteCoinUseCase
        setupSearch()
    }
    
    // MARK: - Public
    
    func viewTask() async {
        await updateAssets()
    }
    
    func favoriteButtonTapped(item: AddAssetItemViewModel) async {
        do {
            let coin = item.model
            let updatedCoin: CoinAsset
            if coin.isFavorite {
                updatedCoin = try await removeFavoriteCoinUseCase.execute(coin)
            } else {
                updatedCoin = try await addFavoriteCoinUseCase.execute(coin)
            }
            item.updateModel(updatedCoin)
        } catch {
            errorModel = ErrorModel(error: error)
        }
    }
}

// MARK: - Private

private extension AddAssetViewModel {
    private func setupSearch() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] _ in
                Task { await self?.updateAssets() }
            }.store(in: &bag)
    }
    
    private func updateAssets() async {
        if coins.isEmpty {
            isLoading = true
        }
        
        do {
            let result = try await searchCoinsUseCase.execute(searchQuery)
            coins = result.map(AddAssetItemViewModel.init)
        } catch {
            errorModel = ErrorModel(error: error)
        }
        isLoading = false
    }
}
