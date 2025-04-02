//
//  Date+Extension.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 02.04.2025.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: self, to: now)
        
        if let years = components.year, years > 0 {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: self)
        }
        
        if let months = components.month, months > 0 {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: self)
        }
        
        if let days = components.day, days > 0 {
            if days == 1 {
                return "Yesterday"
            } else {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                return formatter.string(from: self)
            }
        }
        
        if let hours = components.hour, hours > 0 {
            if hours == 1 {
                return "1 hour ago"
            } else {
                return "\(hours) hours ago"
            }
        }
        
        if let minutes = components.minute, minutes > 0 {
            if minutes == 15 {
                return "15 mins ago"
            } else if minutes == 30 {
                return "30 mins ago"
            } else {
                return "\(minutes) mins ago"
            }
        }
        
        return "Just now"
    }
}
