//
//  ImageTemporaryCacheManager.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import Foundation

public final class ImageTemporaryCacheManager<T> {
    private let cacheLimit: Int
    private var cache: [URL: T] = [:]
    private let isolationQueue = DispatchQueue(label: "ImageTemporaryCacheManager", attributes: .concurrent)
    public init(cacheCount: Int = 50) {
        cacheLimit = cacheCount
    }

    public func saveImage(_ image: T, at url: URL) {
        isolationQueue.async(flags: .barrier) {
            let firstKey = self.cache.keys.first
            self.cache[url] = image
            if self.cache.count > self.cacheLimit, let firstKey {
                self.cache.removeValue(forKey: firstKey)
            }
        }
    }

    public func getCachedImage(_ url: URL) -> T? {
        isolationQueue.sync { cache[url] }
    }
}
