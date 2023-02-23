//
//  MockService.swift
//  SectionsTests
//
//  Created by Tony Ayoub on 23-02-2023.
//

import Foundation

class MockService: PageService {
    func getSections() async -> [Sections.Section] {
        MockService.response
    }
    
    static var response: [Section] {
        [
            Section(title: "Section1", uuid: .init(uuidString: "35bb8a90-d40e-11e2-8b8b-0800200c9a66")!),
            Section(title: "Section2", uuid: .init(uuidString: "38a95382-b31e-11ed-afa1-0242ac120002")!),
            Section(title: "Section3", uuid: .init(uuidString: "3f21c5dc-b31e-11ed-afa1-0242ac120002")!),
            Section(title: "Section4", uuid: .init(uuidString: "42bccaca-b31e-11ed-afa1-0242ac120002")!)
        ]
    }
}
