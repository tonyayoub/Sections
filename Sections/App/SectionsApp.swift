//
//  SectionsApp.swift
//  Sections
//
//  Created by Tony Ayoub on 21-02-2023.
//

import SwiftUI

@main
struct SectionsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView(syncing: syncing)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    var syncing: Syncing {
        Syncing(
            service: ViaPageService(),
            store: CoreDataSectionStore(
                context: persistenceController.container.viewContext
            ))
    }
}
