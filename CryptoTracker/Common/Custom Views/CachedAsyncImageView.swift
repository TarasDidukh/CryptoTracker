//
//  CachedAsyncImageView.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import SwiftUI

private let cacheManager = ImageTemporaryCacheManager<Image>(cacheCount: 200)

/// Loads, displays and caches a modifiable image from the specified URL.
public struct CachedAsyncImageView<Content: View, Placeholder: View>: View {
    private let url: URL?
    private let placeholder: () -> Placeholder
    private let content: (Image) -> Content

    public init(
        url: URL?,
        @ViewBuilder content: @escaping (Image) -> Content,
        placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.placeholder = placeholder
        self.content = content
    }

    public var body: some View {
        if let url, let cachedImage = cacheManager.getCachedImage(url) {
            content(cachedImage)
        } else {
            AsyncImage(url: url, content: cacheAndRender, placeholder: placeholder)
        }
    }

    private func cacheAndRender(_ image: Image) -> some View {
        if let url {
            cacheManager.saveImage(image, at: url)
        }
        return content(image)
    }
}
