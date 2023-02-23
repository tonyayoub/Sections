//
//  ViaPageService.swift
//  Sections
//
//  Created by Tony Ayoub on 21-02-2023.
//

import Foundation

struct ViaPageService: PageService {
    let urlString = "https://content.viaplay.com/ios-se"
    func getSections() async -> [Section] {
        guard let url = URL(string: urlString) else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let page = try JSONDecoder().decode(Page.self, from: data)
            return page.links.sections.map { Section(title: $0.title, uuid: $0.uuid) }
        } catch {
            print("Error decoding api response: \(error.localizedDescription)")
            return []
        }
    }
}
