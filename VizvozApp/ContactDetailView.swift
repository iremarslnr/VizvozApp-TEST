//
//  ContactNameList.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 15/12/24.
//
import SwiftUI


struct ContactDetailView: View {
    var contact: Contact
    @Environment(\.modelContext) private var modelContext
    @State private var modify = false

    var body: some View {
        VStack {
            ZStack {
                Image(.oval)
                Image(systemName: "person.fill")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 20))
            }
            .padding()

            Form {
                Section("Name") {
                    Text(contact.name)
                }
                Section("Surname") {
                    Text(contact.surname)
                }
                Section("How you met") {
                    Text(contact.howYouMet)
                }
                Section("Relationship") {
                    Text(contact.relationship)
                }
                Section("Info") {
                    Text(contact.info)
                }
                Section("Help to remember") {
                    Text(contact.helpToRemember)
                }

                NavigationLink(destination: VoiceRecorderApp()) {
                    Text("All Recording")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Modify") {
                        modify.toggle()
                    }
                    .accessibilityLabel("Modify Contact")
                    .accessibilityHint("Tap to modify the contact")
                }
            }
            .sheet(isPresented: $modify) {
                ModifyContactView(contact: contact)
            }
            .navigationTitle("\(contact.name) \(contact.surname)")
            .navigationBarTitleDisplayMode(.large)
            .preferredColorScheme(.dark)
        }
    }
}

        
    
        
        
        
        
struct ModifyContactView: View {
    @Bindable var contact: Contact
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $contact.name)
                }
                Section("Surname") {
                    TextField("Surname", text: $contact.surname)
                }
                Section("How you met") {
                    TextField("How you met", text: $contact.howYouMet)
                }
                Section("Relationship") {
                    TextField("Relationship", text: $contact.relationship)
                }
                Section("Info") {
                    TextField("Info", text: $contact.info)
                }
                Section("Help to remember") {
                    TextField("Help to remember", text: $contact.helpToRemember)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveContact()
                        dismiss()
                    }
                    .accessibilityLabel("Save Contact")
                    .accessibilityHint("Tap to save changes to the contact")
                }
            }
            .navigationTitle("Modify Contact")
            .preferredColorScheme(.dark)
        }
    }

    private func saveContact() {
        do {
            try modelContext.save() // Save changes to the persistent store
        } catch {
            print("Failed to save contact: \(error)")
        }
    }
}
    

