//
//  NetworkError.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 31.03.2025.
//

enum NetworkError: Error {
    case invalidUrl
    case invalidStatusCode(Int)
    case requestError(Error)
}
