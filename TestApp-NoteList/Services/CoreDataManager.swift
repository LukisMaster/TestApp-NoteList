//
//  CoreDataManager.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 15.02.2023.
//

import CoreData

final class CoreDataManager: ObservableObject {
    
    static let shared = CoreDataManager()
    private let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    private init () {
        container = NSPersistentContainer(name: "NoteListContainer")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Data saved successfully")
        } catch {
            context.rollback()
            fatalError(error.localizedDescription)
        }
    }

}
