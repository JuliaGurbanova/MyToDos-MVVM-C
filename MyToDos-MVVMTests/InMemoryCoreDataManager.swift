//
//  InMemoryCoreDataManager.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import Foundation
import CoreData

@testable import MyToDos_MVVM

class InMemoryCoreDataManager: CoreDataManager {
    override init() {
        super.init()

        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        persistentStoreDescription.url = URL(fileURLWithPath: "/dev/null")
        persistentStoreDescription.shouldAddStoreAsynchronously = false

        let container = NSPersistentContainer(name: "ToDoList")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        persistentContainer = container
    }
}
