//
//  PopularCoinDTO.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import Foundation

struct CoinMarketDataDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case marketCapRank = "market_cap_rank"
        case image
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
    
    let id: String
    let name: String
    let symbol: String
    let marketCapRank: Int
    var currentPrice: Decimal?
    var image: String?
    var priceChangePercentage24h: Decimal
}
