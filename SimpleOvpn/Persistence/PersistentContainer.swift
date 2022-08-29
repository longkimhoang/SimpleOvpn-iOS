//
//  PersistentContainer.swift
//  SimpleOvpn
//
//  Created by Kim Long on 23/08/2022.
//

import CoreData
import Foundation
import os

protocol PersistenceProviding: Actor {
    var container: NSPersistentContainer { get }

    func saveContext(_ context: NSManagedObjectContext?) async
}

extension PersistenceProviding {
    func saveContext(_ context: NSManagedObjectContext? = nil) async {
        await saveContext(context)
    }
}

actor PersistenceProvider: PersistenceProviding {

    static let shared = PersistenceProvider()

    private let inMemory: Bool
    private let logger = Logger(category: "Persistence")

    init(inMemory: Bool = false) {
        self.inMemory = inMemory
    }

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SimpleOvpn")

        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Failed to retrieve a persistent store description.")
        }

        if inMemory {
            description.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                self.logger.error("Load persistent stores failed: \(error)")
            }
        }

        return container
    }()

    func saveContext(_ context: NSManagedObjectContext?) async {
        let context = context ?? container.viewContext
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
