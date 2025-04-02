//
//  Constants.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 31.03.2025.
//

enum Constants {
    static let coingeckoBaseUrl: String = Configuration.value(for: "COINGECKO_BASE_URL")
    static let binanceBaseUrl: String = Configuration.value(for: "BINANCE_BASE_URL")
    static let coingeckoApiKey: String = Configuration.value(for: "COINGECKO_API_KEY")
    static let defaultQuoteCoin = "USDT"
}

extension Constants {
    enum Keys {
        static let latestPriceUpdateDate = "latestPriceUpdateDate"
        static let binanceSupportedCoins = "binanceSupportedCoins"
    }
}
