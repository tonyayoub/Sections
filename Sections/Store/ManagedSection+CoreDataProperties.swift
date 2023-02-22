//
//  ManagedSection+CoreDataProperties.swift
//  Sections
//
//  Created by Tony Ayoub on 22-02-2023.
//
//

import Foundation
import CoreData


extension ManagedSection: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedSection> {
        return NSFetchRequest<ManagedSection>(entityName: "Section")
    }

    @NSManaged public var title: String?
    @NSManaged public var uuid: UUID?

}

// CoreData helpers
extension ManagedSection {
    static func fetchAll(in context: NSManagedObjectContext) throws -> [ManagedSection] {
        try context.fetch(fetchRequest())
    }
    
    /// Deletes IDs that don't exist in backend and returns a list of remaining IDs.
    static func deleteExtraLocalSections(backendIDs: [UUID], in context: NSManagedObjectContext) throws -> [UUID] {
        var localIDsPersistedOnBackend = [UUID]()
        let allLocalSections = try fetchAll(in: context)
        allLocalSections.forEach {
            if let localID = $0.uuid, backendIDs.contains(localID) {
                localIDsPersistedOnBackend.append(localID)
            } else {
                context.delete($0)
            }
        }
        try context.save()
        return localIDsPersistedOnBackend
    }
}
