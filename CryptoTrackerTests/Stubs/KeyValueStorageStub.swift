//
//  KeyValueStorageStub.swift
//  CryptoTrackerTests
//
//  Created by Taras Didukh on 02.04.2025.
//

@testable import CryptoTracker
import Foundation

final class KeyValueStorageStub: KeyValueStorage {
    var setValueCallback: ((Any?, String) -> Void)?
    func setValue(_ value: Any?, forKey: String) {
        setValueCallback?(value, forKey)
    }
    
    var stringCallback: ((String) -> String?)?
    func string(forKey: String) -> String? {
        stringCallback?(forKey)
    }
    
    var dateCallback: ((String) -> Date?)?
    func date(forKey: String) -> Date? {
        dateCallback?(forKey)
    }
}
