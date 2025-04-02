//
//  CoinAsset+TestData.swift
//  CryptoTrackerTests
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker

let mockCoinAssets: [CoinAsset] = [
    CoinAsset(
        id: "bitcoin",
        name: "Bitcoin",
        symbol: "BTC",
        marketCapRank: 1,
        image: "https://example.com/bitcoin.png",
        currentPrice: 82000.01,
        priceChange24hPercentage: 2.3589,
        isFavorite: true
    ),
    CoinAsset(
        id: "ethereum",
        name: "Ethereum",
        symbol: "ETH",
        marketCapRank: 2,
        image: "https://example.com/ethereum.png",
        currentPrice: 3187.65,
        priceChange24hPercentage: -1.0423,
        isFavorite: false
    ),
    CoinAsset(
        id: "cardano",
        name: "Cardano",
        symbol: "ADA",
        marketCapRank: 3,
        image: "https://example.com/cardano.png",
        currentPrice: 2.31,
        priceChange24hPercentage: 5.1234,
        isFavorite: true
    ),
    CoinAsset(
        id: "binancecoin",
        name: "Binance Coin",
        symbol: "BNB",
        marketCapRank: 4,
        image: "https://example.com/binancecoin.png",
        currentPrice: 417.56,
        priceChange24hPercentage: 0.2587,
        isFavorite: false
    ),
    CoinAsset(
        id: "solana",
        name: "Solana",
        symbol: "SOL",
        marketCapRank: 5,
        image: "https://example.com/solana.png",
        currentPrice: 178.44,
        priceChange24hPercentage: -3.8965,
        isFavorite: false
    )
]
