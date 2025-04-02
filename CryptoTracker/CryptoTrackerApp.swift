//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 31.03.2025.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            HomeViewBuilder().build()
                .preferredColorScheme(.light)
        }
    }
}
