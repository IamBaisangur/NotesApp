//
//  NoteEntity+CoreDataProperties.swift
//  NotesApp
//
//  Created by Байсангур on 08.02.2023.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var text: String?
    @NSManaged public var bodyNote: String?

}

extension NoteEntity : Identifiable {

}
