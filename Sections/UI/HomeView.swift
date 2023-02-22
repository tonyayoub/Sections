//
//  HomeView.swift
//  Sections
//
//  Created by Tony Ayoub on 21-02-2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    let syncing: Syncing
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var sections: FetchedResults<ManagedSection>

    var body: some View {
        List(sections) { language in
            Text(language.title ?? "Unknown")
        }
        .task {
            await syncing.syncWithBackend()
        }
        .refreshable {
            await syncing.clear()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let syncing = Syncing(service: ViaPageService(), store: CoreDataSectionStore(context: PersistenceController.preview.container.viewContext))
        HomeView(syncing: syncing).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
