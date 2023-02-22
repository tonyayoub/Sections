//
//  Syncing.swift
//  Sections
//
//  Created by Tony Ayoub on 22-02-2023.
//

import CoreData

class Syncing {
    let service: PageService
    let store: SectionStore
    
    init(service: PageService, store: SectionStore) {
        self.service = service
        self.store = store
    }
    func clear() async {
        store.clearExistingSections()
    }
    func syncWithBackend() async {
        print("Syncing with backend")
        let sections = await service.getSections()
        if !sections.isEmpty {
            store.replaceExistingSections(sections: sections)
        } else {
            print("Empty section list. Old data will not be replaced.")
        }
        
    }
}
