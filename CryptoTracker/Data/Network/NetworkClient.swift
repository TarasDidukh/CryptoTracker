//
//  NetworkClient.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 31.03.2025.
//

import Foundation

final class NetworkClient: NetworkClientProtocol {
    static let shared = NetworkClient()
    
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = TimeInterval(10)
        urlSession = URLSession(configuration: config)
        decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func get<TResult>(_ requestType: RequestType) async throws -> TResult where TResult : Decodable {
        var request = try URLRequest(url: requestType.url)
        request.allHTTPHeaderFields?.merge(requestType.headers) { current, _ in
            current
        }
        
        let data: Data
        let urlResponse: URLResponse
        do {
            (data, urlResponse) = try await URLSession.shared.data(for: request)
        } catch {
            throw NetworkError.requestError(error)
        }
        if let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode, statusCode != 200 {
            throw NetworkError.invalidStatusCode(statusCode)
        }
        
        let result = try decoder.decode(TResult.self, from: data)
        return result
    }
}
