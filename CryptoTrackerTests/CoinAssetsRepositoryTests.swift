//
//  CoinAssetsRepositoryTests.swift
//  CryptoTrackerTests
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker
import XCTest

// Examples how I write tests.
// Didn't cover everything to not spent too much time on the test task.

class CoinAssetsRepositoryTests: XCTestCase {
    var sut: CoinAssetsRepositoryImpl!
    let coinAssetsServiceStub = CoinAssetsServiceStub()
    let coinAssetsStorageStub = CoinAssetsStorageStub()
    let binanceAssetsServiceStub = BinanceAssetsServiceStub()
    let keyValueStorageStub = KeyValueStorageStub()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = CoinAssetsRepositoryImpl(coinAssetsService: coinAssetsServiceStub, coinAssetsStorage: coinAssetsStorageStub, binanceAssetsService: binanceAssetsServiceStub, keyValueStorage: keyValueStorageStub)
    }
    
    func testFetchLatestPrices_FromBinanceOnly() async throws {
        // GIVEN
        let coinAssets = mockCoinAssets
        let supportedSymbols = coinAssets.map { $0.symbol.uppercased() }.joined(separator: ",")
        
        var stringCalls: [String] = []
        keyValueStorageStub.stringCallback = { key in
            stringCalls.append(key)
            if key == Constants.Keys.binanceSupportedCoins {
                return supportedSymbols
            }
            return nil
        }
        
        let binanceCoinAssets = coinAssets.map {
            var coinAsset = $0
            coinAsset.currentPrice? += 10
            coinAsset.priceChange24hPercentage? += 0.2
            return coinAsset
        }
        var fetchLatestBinancePricesCalls = [[CoinAsset]]()
        binanceAssetsServiceStub.fetchLatestPricesCallback = { symbols in
            fetchLatestBinancePricesCalls.append(symbols)
            return binanceCoinAssets
        }
        
        var fetchCoinsMarketDataCalls = [[String]]()
        coinAssetsServiceStub.fetchCoinsMarketDataCallback = { ids in
            fetchCoinsMarketDataCalls.append(ids)
            return []
        }
        
        var saveCoinsCalls = [[CoinAsset]]()
        coinAssetsStorageStub.saveCoinsCallback = { coinAssets in
            saveCoinsCalls.append(coinAssets)
        }
        
        var setValueCalls = [(Any?, String)]()
        keyValueStorageStub.setValueCallback = { value, key in
            setValueCalls.append((value, key))
        }
        
        // WHEN
        let result = try await sut.fetchLatestPrices(for: coinAssets)
        
        // THEN
        XCTAssertEqual(result, binanceCoinAssets)
        XCTAssertEqual(stringCalls, [Constants.Keys.binanceSupportedCoins])
        XCTAssertEqual(fetchLatestBinancePricesCalls, [coinAssets])
        XCTAssertEqual(fetchCoinsMarketDataCalls, [[]])
        XCTAssertEqual(saveCoinsCalls, [binanceCoinAssets])
        XCTAssertEqual(setValueCalls.count, 1)
        let (value, key) = try XCTUnwrap(setValueCalls.first)
        XCTAssertEqual(key, Constants.Keys.latestPriceUpdateDate)
        XCTAssertEqual((value as? Date)?.isInLast10Seconds(), true)
    }
}

extension Date {
    func isInLast10Seconds() -> Bool {
        let now = Date()
        let timeInterval = now.timeIntervalSince(self)
        return timeInterval <= 10 && timeInterval >= 0
    }
}
 
