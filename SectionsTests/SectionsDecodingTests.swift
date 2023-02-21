//
//  SectionsDecodingTests.swift
//  SectionsTests
//
//  Created by Tony Ayoub on 21-02-2023.
//

import XCTest
@testable import Sections

final class SectionsDecodingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        if let url = Bundle(for: SectionsDecodingTests.self)
            .url(forResource: "sample-response", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Page.self, from: data)
                print(jsonData)
//                let jsonData = try decoder.decode(ResponseData.self, from: data)
//                return jsonData.person

            } catch {
                print("error:\(error)")
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
