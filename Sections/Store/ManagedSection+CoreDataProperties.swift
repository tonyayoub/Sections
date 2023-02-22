//
//  ManagedSection+CoreDataProperties.swift
//  Sections
//
//  Created by Tony Ayoub on 22-02-2023.
//
//

import Foundation
import CoreData


extension ManagedSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedSection> {
        return NSFetchRequest<ManagedSection>(entityName: "Section")
    }
}

extension ManagedSection : Identifiable {

}
