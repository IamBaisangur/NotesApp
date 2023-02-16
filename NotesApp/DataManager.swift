//
//  DataManager.swift
//  NotesApp
//
//  Created by Байсангур on 13.02.2023.
//

import Foundation
import CoreData

final class DataManager {
    private let frc = CoreDataService.shared.fetchedResultsController
    
    init(delegate: NSFetchedResultsControllerDelegate) {
        self.frc.delegate = delegate
        self.performFetch()
    }
    
    func count() -> Int {
        return frc.sections?.first?.numberOfObjects ?? 0
    }
    
    func object(at indexPath: IndexPath) -> NoteEntity {
        return self.frc.object(at: indexPath)
    }
    
    func createNote(text: String, bodyNote: String) {
        CoreDataService.shared.createNote(text: text, bodyNote: bodyNote)
    }
    
    func deleteNote(_ note: NoteEntity) {
        CoreDataService.shared.deleteNote(note)
    }
    
    func saveContext() {
        CoreDataService.shared.saveContext()
    }
    
    private func performFetch() {
        do {
            try self.frc.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Error \(nserror), \(nserror.userInfo)")
        }
    }
}
