//
//  Page.swift
//  Sections
//
//  Created by Tony Ayoub on 21-02-2023.
//

import Foundation

struct Page: Codable {
    let links: Link
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

struct Link: Codable {
    let sections: [Section]
    
    enum CodingKeys: String, CodingKey {
        case sections = "viaplay:sections"
    }
}

struct Section: Codable {
    let title: String
}



