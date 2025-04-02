//
//  FavoriteAssetItemViewModel.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import SwiftUI

final class FavoriteAssetItemViewModel: ObservableObject, Identifiable {
    var id: String { model.id }
        
    private(set) var model: CoinAsset
    @Published private(set) var isPositivePriceChange: Bool?
    
    init(model: CoinAsset) {
        self.model = model
    }
    
    func update(with model: CoinAsset) {
        let isPriceUpdated = self.model.currentPrice != model.currentPrice
        if isPriceUpdated {
            isPositivePriceChange = (self.model.currentPrice ?? 0) < (model.currentPrice ?? 0)
        }
        self.model = model
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isPositivePriceChange = nil
        }
    }
}
