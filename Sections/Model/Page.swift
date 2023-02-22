//
//  Page.swift
//  Sections
//
//  Created by Tony Ayoub on 21-02-2023.
//

import Foundation

struct Page: Decodable {
    let links: Link
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

struct Link: Decodable {
    let sections: [Section]
    
    enum CodingKeys: String, CodingKey {
        case sections = "viaplay:sections"
    }
}

struct Section {
    let title: String
    let uuid: UUID
}

extension Section: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case uuid = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        print("title: \(title)")
        if let uuid = try? container.decode(UUID.self, forKey: .uuid) {
            self.uuid = uuid
        } else {
            print("UUID is not valid. A new UUID will be assigned")
            self.uuid = UUID()
        }
    }
}



