//
//  CoreDataStack.swift
//  CryptoTracker
//
//  Created by Taras Didukh on 01.04.2025.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    private let name = "DatabaseModels"
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError()
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
    
    @discardableResult
    func performBackgroundTask<T>(_ block: @escaping (NSManagedObjectContext) throws -> T) async rethrows -> T {
        do {
            return try await container.performBackgroundTask(block)
        } catch {
            throw CoreDataError(underlyingError: error)
        }
    }
}
