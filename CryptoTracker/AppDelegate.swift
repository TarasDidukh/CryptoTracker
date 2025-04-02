//
//  AppDelegate.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        BinanceSupportedCoinsOperation.shared.fethAndCacheSupportedCoins()
        let _ = CoreDataStack.shared
        return true
    }
}
