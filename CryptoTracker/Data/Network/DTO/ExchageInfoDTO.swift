//
//  ExchageInfoDTO.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

struct ExchageInfoDTO: Decodable {
    let symbols: [ExchangeSymbolDTO]
}

struct ExchangeSymbolDTO: Decodable {
    let baseAsset: String
    let quoteAsset: String
}
