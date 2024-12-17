//
//  ContactNameList.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 15/12/24.
//

import Foundation
import SwiftData

@Model
final class Contact {
    @Attribute(.unique) var id: UUID
    var name: String
    var surname: String
    var howYouMet: String
    var relationship: String
    var info: String
    var helpToRemember: String

    init(name: String, surname: String, howYouMet: String, relationship: String, info: String, helpToRemember: String) {
        self.id = UUID()
        self.name = name
        self.surname = surname
        self.howYouMet = howYouMet
        self.relationship = relationship
        self.info = info
        self.helpToRemember = helpToRemember
    }
}




