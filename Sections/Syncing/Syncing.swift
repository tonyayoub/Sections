//
//  Syncing.swift
//  Sections
//
//  Created by Tony Ayoub on 22-02-2023.
//

import CoreData

class Syncing {
    private let service: PageService
    private let store: SectionStore
    
    init(service: PageService, store: SectionStore) {
        self.service = service
        self.store = store
    }

    func syncWithBackend() async {
        print("Syncing with backend")
        let sections = await service.getSections()
        if !sections.isEmpty {
            store.updateSections(sections: sections)
        } else {
            print("Empty section list. Old data will not be replaced.")
        }
        
    }
}
