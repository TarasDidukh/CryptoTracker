//
//  KeyValueStorage.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import Foundation

protocol KeyValueStorage {
    func setValue(_ value: Any?, forKey: String)
    func string(forKey: String) -> String?
    func date(forKey: String) -> Date?
}

extension UserDefaults: KeyValueStorage {
    func date(forKey: String) -> Date? {
        object(forKey: forKey) as? Date
    }
}
