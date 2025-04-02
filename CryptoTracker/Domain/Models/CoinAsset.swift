//
//  CoinAsset.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import Foundation

struct CoinAsset: Identifiable, Equatable {
    let id: String
    let name: String
    let symbol: String
    let marketCapRank: Int
    var image: String?
    var currentPrice: Decimal?
    var priceChange24hPercentage: Decimal?
    var isFavorite = false
    
    var pricePercentageChange: Decimal? {
        return priceChange24hPercentage?.rounded(to: 2)
    }
        
}

// MARK: - Map to Domain

extension CoinAsset {
    init(from model: CoinMarketDataDTO) {
        id = model.id
        name = model.name
        symbol = model.symbol
        marketCapRank = model.marketCapRank
        image = model.image
        currentPrice = model.currentPrice
        priceChange24hPercentage = model.priceChangePercentage24h
    }
    
    init(from model: SearchCoinDTO) {
        id = model.id
        name = model.name
        symbol = model.symbol
        marketCapRank = model.marketCapRank
        image = model.image
    }
    
    init?(from model: CoinAssetEntity) {
        guard let id = model.id,
              let name = model.name,
              let symbol = model.symbol else { return nil }
        self.id = id
        self.name = name
        self.symbol = symbol
        self.isFavorite = model.isFavorite
        self.marketCapRank = Int(model.marketCapRank)
        self.image = model.image
        self.currentPrice = model.currentPrice as? Decimal
        self.priceChange24hPercentage = model.priceChange24hPercentage as? Decimal
    }
    
    func updated(with latestPrice: SymbolLatestPriceDTO) -> CoinAsset {
        var coin = self
        coin.currentPrice = Decimal(string: latestPrice.lastPrice)
        coin.priceChange24hPercentage = Decimal(string: latestPrice.priceChangePercent)
        return coin
    }
}

// MARK: - Map to CoreData

extension CoinAssetEntity {
    func copy(from model: CoinAsset) {
        id = model.id
        name = model.name
        symbol = model.symbol
        marketCapRank = Int32(model.marketCapRank)
        image = model.image
        currentPrice = model.currentPrice as? NSDecimalNumber
        priceChange24hPercentage = model.priceChange24hPercentage as? NSDecimalNumber
    }
}
