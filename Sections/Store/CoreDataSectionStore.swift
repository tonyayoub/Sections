//
//  CoreDataSectionStore.swift
//  Sections
//
//  Created by Tony Ayoub on 22-02-2023.
//

import CoreData

class CoreDataSectionStore: SectionStore {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func updateSections(sections: [Section]) {
        do {
        let backendIDs = sections.map { $0.uuid }
        let alreadyExistingIDs = try ManagedSection.deleteExtraLocalSections(
            backendIDs: backendIDs,
            in: context
        )
            
            let newSectionsToAdd = sections.filter { !alreadyExistingIDs.contains($0.uuid) }
            newSectionsToAdd.forEach {
                let managedSection = ManagedSection(context: context)
                managedSection.title = $0.title
                managedSection.uuid = $0.uuid
            }
            try context.save()
        } catch {
            print("Error saving new sections: \(error.localizedDescription)")
        }
    }
}
