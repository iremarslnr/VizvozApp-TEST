//
//  AddNewContact.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 11/12/24.
//

import SwiftUI

struct AddNewContact: View {
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var howYouMet: String = ""
    @State private var relationship: String = ""
    @State private var info: String = ""
    @State private var helptoremember: String = ""
    
    var onAdd: (String, String, String, String, String, String) -> Void
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Name"){
                    TextField("", text: $name)
                    
                }
                Section("Surname") {
                    TextField("", text: $surname)
                }
                Section("How you met") {
                    TextField("", text: $howYouMet)
                        .accessibilityHint("Describe how you met this person")
                }
                Section("Relationship") {
                    TextField("", text: $relationship)
                        .accessibilityHint("Describe your relationship type with this person")
                }
                Section("Info") {
                    TextField("", text: $info)
                        .accessibilityHint("Provide neccessary information about this person")
                }
                Section("Help to remember") {
                    TextField("", text: $helptoremember)
                        .accessibilityHint("Describe some hints for you to remember this person")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        showModal.toggle()
                    }
                    .accessibilityLabel("Cancel, button")
                    .accessibilityHint("Tap to  cancel.")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        onAdd(name, surname, howYouMet, relationship, info, helptoremember)
                        showModal.toggle()
                    }
                    .accessibilityLabel("Add, button")
                    .accessibilityHint("Tap to  add the contact.")
                }
            }
            .navigationTitle("New Contact")
        }
    }
}


