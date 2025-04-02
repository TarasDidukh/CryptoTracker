//
//  NetworkClientProtocol.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 31.03.2025.
//

import Foundation

protocol NetworkClientProtocol: AnyObject {
    func get<TResult: Decodable>(_ requestType: RequestType) async throws -> TResult
}
