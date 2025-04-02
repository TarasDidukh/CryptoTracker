//
//  RequestType.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import Foundation

protocol RequestType {
    var baseUrl: String { get }
    var endpoint: String { get }
    var queries: [String: String] { get }
    var headers: [String: String] { get }
}

extension RequestType {
    var url: URL {
        get throws {
            guard var components = URLComponents(string: "https://" + baseUrl + endpoint) else {
                throw NetworkError.invalidUrl
            }
            
            components.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
            guard let url = components.url else {
                throw NetworkError.invalidUrl
            }
            
            return url
        }
    }
}
