//  ContactPage.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 11/12/24.
//
import SwiftUI
import SwiftData

struct ContactPage: View {
    @Query(sort: \Contact.name, order: .forward) private var contacts: [Contact]
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddContactView = false
    @State private var searchText = ""
    let imageNames = ["Oval", "Oval2", "Oval3", "Oval4", "Oval5"]
    
    var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { contact in
                contact.name.lowercased().contains(searchText.lowercased()) ||
                contact.surname.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Image(.vizvoz)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .accessibilityHidden(true)
                
                Spacer()
                
                TextField("Search", text: $searchText)
                    .padding(10)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .accessibilityLabel("Search for contacts")
                    .accessibilityHint("Enter text to search for contacts")
                    .accessibilityValue(searchText.isEmpty ? "No search text entered" : "Search query: \(searchText)")
                
                
                Spacer()
                
                Button {
                    showingAddContactView = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(Color.white)
                        .fixedSize()
                }
                .accessibilityLabel("Add contact")
                .accessibilityHint("Tap to add new contact")
            }
            .padding(.horizontal)
            
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 350, height: 110)
                    .foregroundStyle(Color.label)
                    .padding(.top, 40)
                    .padding(.horizontal)
                
                Text("Create your contacts to remember people with their voices.  \( Image(.tik))")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20))
                    .italic()
                    .multilineTextAlignment(.center)
                    .scenePadding()
                    .padding(.top, 30)
                
            }
            .padding(.horizontal)
            .padding(25)
            
            NavigationView {
                if filteredContacts.isEmpty {
                    VStack {
                        ContentUnavailableView {
                            Label("No Contacts", systemImage: "person.crop.circle.badge.xmark")
                        } description: {
                            Text("New contacts that you add will appear here.")
                        } actions: {
                            Button {
                                showingAddContactView = true
                            } label: {
                                Text("Add your first contact")
                            }
                            .accessibilityLabel("Add contact")
                            .accessibilityHint("Tap to add your first contact")
                        }
                        .preferredColorScheme(.dark)
                    }
                    .navigationTitle("Contacts")
                } else {
                    List {
                        ForEach(filteredContacts) { contact in
                            NavigationLink(destination: ContactDetailView(contact: contact)) {
                                HStack {
                                    ZStack {
                                        let imageIndex = (contacts.firstIndex(of: contact) ?? 0) % imageNames.count
                                        Image(imageNames[imageIndex])
                                        Text(String(contact.name.prefix(2)))
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 20))
                                    }
                                    Text(contact.name)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .onDelete(perform: deleteContact)
                    }
                    .navigationTitle("Contacts")
                    .background(.label)
                    .preferredColorScheme(.dark)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddContactView) {
                AddNewContact(
                    onAdd: { name, surname, howYouMet, relationship, info, helpToRemember in
                        addContact(
                            name: name,
                            surname: surname,
                            howYouMet: howYouMet,
                            relationship: relationship,
                            info: info,
                            helpToRemember: helpToRemember
                        )
                    },
                    showModal: $showingAddContactView
                )
            }
        }
        
    }
    
    private func addContact(name: String, surname: String, howYouMet: String, relationship: String, info: String, helpToRemember: String) {
        let newContact = Contact(
            name: name,
            surname: surname,
            howYouMet: howYouMet,
            relationship: relationship,
            info: info,
            helpToRemember: helpToRemember
        )
        modelContext.insert(newContact)
    }
    
    private func deleteContact(at offsets: IndexSet) {
        for index in offsets {
            let contact = contacts[index]
            modelContext.delete(contact)
        }
    }
}


#Preview {
    ContactPage()
}
