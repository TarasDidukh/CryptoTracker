//
//  Untitled.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import Foundation

final class NumberFormatterProvider {
    private let lowestPriceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 8
        formatter.minimumFractionDigits = 8
        formatter.decimalSeparator = "."
        formatter.roundingMode = .down
        return formatter
    }()
    
    private let smallPriceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 4
        formatter.decimalSeparator = "."
        formatter.roundingMode = .down
        return formatter
    }()
    
    private let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.roundingMode = .down
        return formatter
    }()
    
    let percentageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.roundingMode = .down
        formatter.negativePrefix = "-"
        formatter.negativeSuffix = "%"
        formatter.positivePrefix = "+"
        formatter.positiveSuffix = "%"
        return formatter
    }()
    
    func getFormatter(for price: Decimal) -> NumberFormatter {
        if price < 0.0001 {
            return lowestPriceFormatter
        } else if price < 10 {
            return smallPriceFormatter
        } else {
            return priceFormatter
        }
    }
}
