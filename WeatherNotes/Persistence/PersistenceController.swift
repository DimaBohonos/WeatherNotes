//
//  PersistenceController.swift
//  WeatherNotes
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    /// In-memory store for Xcode previews.
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        return controller
    }()

    let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext { container.viewContext }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NotesStorage")
        if inMemory {
            guard let description = container.persistentStoreDescriptions.first else { fatalError("Missing persistent store.") }
            description.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error {
                assertionFailure("Core Data unresolved error \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
