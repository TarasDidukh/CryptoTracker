//
//  SymbolLatestPriceDTO.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

struct SymbolLatestPriceDTO: Decodable {
    let symbol: String
    let priceChangePercent: String
    let lastPrice: String
}
