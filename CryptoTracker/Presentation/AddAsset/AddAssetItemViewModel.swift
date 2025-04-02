//
//  AddAssetItemViewModel.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import SwiftUI

final class AddAssetItemViewModel: ObservableObject, Identifiable {
    private(set) var model: CoinAsset
    var id: String { model.id }
    
    @Published private(set) var isFavorite: Bool
    
    init(model: CoinAsset) {
        self.model = model
        isFavorite = model.isFavorite
    }
    
    func updateModel(_ model: CoinAsset) {
        self.model = model
        isFavorite = model.isFavorite
    }
}
