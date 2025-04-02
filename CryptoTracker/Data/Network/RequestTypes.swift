//
//  RequestTypes.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

enum RequestTypes {
    case getTop100Coins
    case searchCoins(query: String)
    case tickersPrice(symbols: [String])
    case exchangeInfo
    case getMarketData(ids: [String])
}

extension RequestTypes: RequestType {
    var baseUrl: String {
        switch self {
        case .getTop100Coins, .searchCoins, .getMarketData:
            Constants.coingeckoBaseUrl
        case .tickersPrice, .exchangeInfo:
            Constants.binanceBaseUrl
        }
    }
    
    var endpoint: String {
        switch self {
        case .getTop100Coins, .getMarketData:
            return "coins/markets"
        case .searchCoins:
            return "search"
        case .tickersPrice:
            return "ticker/24hr"
        case .exchangeInfo:
            return "exchangeInfo"
        }
    }
        
    var queries: [String : String] {
        switch self {
        case .getTop100Coins:
            return ["vs_currency": "usd", "per_page": "100", "page": "1"]
        case .getMarketData(let ids):
            return ["vs_currency": "usd", "ids": ids.joined(separator: ",")]
        case .searchCoins(let query):
            return ["query": query]
        case .tickersPrice(let symbols):
            let symbolsFormatted = "[" + symbols.map { "\"\($0)\""}.joined(separator: ",") + "]"
            return ["symbols": symbolsFormatted]
        case .exchangeInfo:
            return [:]
        }
    }
    
    var headers: [String : String] {
        var headers = ["Accept": "application/json"]
        switch self {
        case .getTop100Coins, .searchCoins, .getMarketData:
            headers["x-cg-demo-api-key"] = Constants.coingeckoApiKey
        case .tickersPrice, .exchangeInfo:
            break
        }
        return headers
    }
}
