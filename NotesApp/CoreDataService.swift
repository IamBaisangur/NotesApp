//
//  CoreDataService.swift
//  NotesApp
//
//  Created by Байсангур on 13.02.2023.
//

import Foundation
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    private init() {}
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var fetchedResultsController: NSFetchedResultsController<NoteEntity> {
        return NSFetchedResultsController(fetchRequest: self.fetchReqest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func createNote(text: String, bodyNote: String) {
        let note = NoteEntity(context: context)
        note.text = text
        note.bodyNote = bodyNote
        self.saveContext()
    }
    
    func fetchReqest() -> NSFetchRequest<NoteEntity> {
        let reqest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        reqest.sortDescriptors = [.init(keyPath: \NoteEntity.text, ascending: true)]
        return reqest
    }
    
    func deleteNote(_ note: NSManagedObject) {
        context.delete(note)
        saveContext()
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NotesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
