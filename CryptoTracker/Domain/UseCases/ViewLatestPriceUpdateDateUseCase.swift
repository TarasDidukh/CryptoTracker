//
//  ViewLatestPriceUpdateDateUseCase.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import Foundation

protocol ViewLatestPriceUpdateDateUseCase {
    func execute() -> Date?
}

final class ViewLatestPriceUpdateDateUseCaseImpl: ViewLatestPriceUpdateDateUseCase {
    private let keyValueStorage: KeyValueStorage
    
    init(keyValueStorage: KeyValueStorage) {
        self.keyValueStorage = keyValueStorage
    }
    
    func execute() -> Date? {
        return keyValueStorage.date(forKey: Constants.Keys.latestPriceUpdateDate)
    }
}
