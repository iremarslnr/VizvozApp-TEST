//
//  ContactNameList.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 15/12/24.
//

import Foundation
import SwiftUI


struct Contact: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var surname: String
    var howYouMet: String

    var relationship: String
    var info: String
    var helpToRemember: String
   
   
}




