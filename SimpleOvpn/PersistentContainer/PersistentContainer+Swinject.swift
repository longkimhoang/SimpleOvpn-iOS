//
//  PersistentContainer+Swinject.swift
//  SimpleOvpn
//
//  Created by Kim Long on 23/08/2022.
//

import CoreData
import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
    func registerPersistentContainer() {
        autoregister(PersistentContainer.self, argument: String.self) { name in
            let container = PersistentContainer(name: name)

            container.loadPersistentStores { _, error in
                guard let error = error as? NSError else { return }
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }

            return container
        }.inObjectScope(.container)
    }
}

extension Resolver {
    func resolvePersistentContainer() -> PersistentContainer {
        resolve(PersistentContainer.self, argument: "SimpleOvpn")!
    }
}
