//
//  SectionsTests.swift
//  SectionsTests
//
//  Created by Tony Ayoub on 21-02-2023.
//

import XCTest
@testable import Sections

final class SectionsTests: XCTestCase {

    func testEmptyStoreGetPopulatedWithBackendSections() async throws {
        let context = PersistenceController(inMemory: true).container.newBackgroundContext()
        let store = CoreDataSectionStore(context: context)
        let syncing = Syncing(service: MockService(), store: store)
        await syncing.syncWithBackend()
        let sections = try ManagedSection.fetchAll(in: context)
        XCTAssertEqual(sections.count, 4)
        let remoteUUIDs = Set(MockService.response.map { $0.uuid })
        let localUUIDs = Set(sections.map { $0.uuid })
        XCTAssertEqual(remoteUUIDs, localUUIDs)
    }
    
    func testExtraLocalSectionDeletedAfterSyncing() async throws {
        let context = PersistenceController(inMemory: true).container.newBackgroundContext()
        context.reset()
        let extraLocalSection = ManagedSection(context: context)
        extraLocalSection.uuid = UUID()
        extraLocalSection.title = "Section 5"
        let localSections = try ManagedSection.fetchAll(in: context)
        XCTAssertEqual(localSections.count, 1)
        
        let syncing = Syncing(service: MockService(), store: CoreDataSectionStore(context: context))
        await syncing.syncWithBackend()
        let localSectionsAfterSyncing = try ManagedSection.fetchAll(in: context)
        XCTAssertEqual(localSectionsAfterSyncing.count, 4)
        XCTAssertFalse(localSectionsAfterSyncing.map { $0.uuid }.contains(extraLocalSection.uuid))
    }
    
    func testLocalSectionExistingRemotelyNotDeleted() async throws {
        let context = PersistenceController(inMemory: true).container.newBackgroundContext()
        context.reset()
        let localSection1 = ManagedSection(context: context)
        localSection1.uuid = MockService.response[0].uuid
        localSection1.title = MockService.response[0].title
        
        let localSection2 = ManagedSection(context: context)
        localSection2.uuid = MockService.response[1].uuid
        localSection2.title = MockService.response[1].title
        
        let localSections = try ManagedSection.fetchAll(in: context)
        XCTAssertEqual(localSections.count, 2)
        
        let syncing = Syncing(service: MockService(), store: CoreDataSectionStore(context: context))
        await syncing.syncWithBackend()
        let localSectionsAfterSyncing = try ManagedSection.fetchAll(in: context)
        XCTAssertEqual(localSectionsAfterSyncing.count, 4)
        XCTAssertTrue(localSectionsAfterSyncing.map { $0.uuid }.contains(localSection1.uuid))
        XCTAssertTrue(localSectionsAfterSyncing.map { $0.uuid }.contains(localSection2.uuid))
    }
}
