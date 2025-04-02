//
//  LoggerProtocol.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import os.log
import Foundation

protocol LoggerProtocol {
    func debug<T>(_ message: T) where T: CustomStringConvertible
}

final class OSLogger: LoggerProtocol {
    static let shared = OSLogger(subsystem: Bundle.main.bundleIdentifier ?? "unknown", category: "debug")
    
    private var logger: Logger
    
    private init(subsystem: String, category: String) {
        logger = Logger(subsystem: subsystem, category: category)
    }
    
    func debug<T>(_ message: T) where T: CustomStringConvertible {
        logger.debug("\(message)")
    }
}
