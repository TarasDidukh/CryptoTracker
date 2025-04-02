//
//  Decimal+Extension.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import Foundation

extension Decimal {
    var nsValue: NSDecimalNumber {
        self as NSDecimalNumber
    }
    
    func rounded(to scale: Int) -> Decimal {
        var result = Decimal()
        var valueCopy = self
        NSDecimalRound(&result, &valueCopy, scale, .plain)
        return result
    }
}
