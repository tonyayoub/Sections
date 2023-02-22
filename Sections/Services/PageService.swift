//
//  PageService.swift
//  Sections
//
//  Created by Tony Ayoub on 21-02-2023.
//

import Foundation

protocol PageService {
    func getSections() async -> [Section]
}
