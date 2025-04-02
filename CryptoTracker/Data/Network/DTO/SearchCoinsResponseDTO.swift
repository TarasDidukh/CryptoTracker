//
//  SearchCoinsResponseDTO.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

struct SearchCoinsResponseDTO: Decodable {
    let coins: [SearchCoinDTO]
}

struct SearchCoinDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case marketCapRank = "market_cap_rank"
        case image = "large"
    }
    
    let id: String
    let name: String
    let symbol: String
    let marketCapRank: Int
    var image: String?
}
