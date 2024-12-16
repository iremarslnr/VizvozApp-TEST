//
//  ContactNameList.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 15/12/24.
//
import SwiftUI


struct ContactDetailView: View {
    @Binding var contact: Contact
    @State private var modify = false
    
    var body: some View {
        
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
                        }
                    }
                    .sheet(isPresented: $modify) {
                        ModifyContactView(contact: $contact)
                    }
                    .navigationTitle("\(contact.name) \(contact.surname)")
                    .navigationBarTitleDisplayMode(.large)
                    .preferredColorScheme(.dark)
                }
            }
        
    
        
        
        
        
        struct ModifyContactView: View {
            @Binding var contact: Contact
            @Environment(\.dismiss) var dismiss
            
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
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Save") {
                                dismiss()
                            }
                        }
                    }
                    .navigationTitle("Modify Contact")
                    .preferredColorScheme(.dark)
                }
            }
        }
    

