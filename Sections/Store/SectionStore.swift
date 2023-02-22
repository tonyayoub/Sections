//
//  SectionStore.swift
//  Sections
//
//  Created by Tony Ayoub on 22-02-2023.
//

import Foundation

protocol SectionStore {
    func replaceExistingSections(sections: [Section])
    func clearExistingSections()
}
