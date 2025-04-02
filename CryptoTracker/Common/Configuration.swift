//
//  Configuration.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import Foundation

enum Configuration {
    enum ConfigError: Error {
        case keyNotFound, invalidValue
    }
    
    static func value<T>(for key: String) -> T {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) else {
            preconditionFailure("Key '\(key)' not found")
        }
        
        guard let typedValue = value as? T else {
            preconditionFailure("Invalid value type for key '\(key)'")
        }
        
        return typedValue
    }
}
