//
//  ViaPageService.swift
//  Sections
//
//  Created by Tony Ayoub on 21-02-2023.
//

import Foundation

struct ViaPageService: PageService {
    let urlString = "https://content.viaplay.com/ios-se"
    func getPage() async -> Page? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let page = try? JSONDecoder().decode(Page.self, from: data)
            return page
        } catch {
            print("Error decoding api response: \(error.localizedDescription)")
            return nil
        }
    }
}
