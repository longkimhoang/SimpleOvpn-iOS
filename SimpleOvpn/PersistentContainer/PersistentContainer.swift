//
//  PersistentContainer.swift
//  SimpleOvpn
//
//  Created by Kim Long on 23/08/2022.
//

import CoreData
import Foundation

final class PersistentContainer: NSPersistentContainer {
    func saveContext(_ context: NSManagedObjectContext? = nil) {
        let context = context ?? viewContext
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
