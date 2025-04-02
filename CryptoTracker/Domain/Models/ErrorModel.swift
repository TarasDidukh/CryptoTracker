//
//  ErrorModel.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

struct ErrorModel {
    let title: String
    let message: String
    
    init(error: Error) {
        switch error {
        case NetworkError.invalidStatusCode(429):
            title = "Too Many Requests"
            message = "Wait for a while and try again."
        case is NetworkError:
            title = "Network error"
            message = "Check your internet and try again."
        case is CoreDataError:
            title = "Database error"
            message = "Oops, something went wrong. Please try again."
        default:
            title = "Error"
            message = "Oops, something went wrong. Please try again later."
        }
    }
}
