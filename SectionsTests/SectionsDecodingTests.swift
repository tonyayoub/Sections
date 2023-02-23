//
//  SectionsDecodingTests.swift
//  SectionsTests
//
//  Created by Tony Ayoub on 21-02-2023.
//

import XCTest
@testable import Sections

final class SectionsDecodingTests: XCTestCase {
    func testDecoding() {
        if let url = Bundle(for: SectionsDecodingTests.self)
            .url(forResource: "sample-response", withExtension: "json") {
            let data = try! Data(contentsOf: url)
            let jsonData = try! JSONDecoder().decode(Page.self, from: data)
            XCTAssertEqual(jsonData.links.sections.count, 4)
            XCTAssertEqual(jsonData.links.sections[0].uuid, UUID(uuidString: "35BB8A90-D40E-11E2-8B8B-0800200C9A66"))
            XCTAssertEqual(jsonData.links.sections[0].title, "Serier")
        }
    }
}
