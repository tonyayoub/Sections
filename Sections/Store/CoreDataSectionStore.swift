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
    
    func replaceExistingSections(sections: [Section]) {
        clearExistingSections()
        
        sections.forEach {
            let managedSection = ManagedSection(context: context)
            managedSection.title = $0.title
            managedSection.uuid = $0.uuid
        }
        do {
            try context.save()
        } catch {
            print("Error saving new sections: \(error.localizedDescription)")
        }
    }

    func clearExistingSections() {
        do {
            let fetchRequest = ManagedSection.fetchRequest()
            let sections = try context.fetch(fetchRequest)
            sections.forEach {
                context.delete($0)
            }
        } catch {
            print("Error deleting existing sections.\(error.localizedDescription)")
        }
        
    }
}
