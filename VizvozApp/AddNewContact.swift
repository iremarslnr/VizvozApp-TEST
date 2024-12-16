//
//  AddNewContact.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 11/12/24.
//

import SwiftUI

struct AddNewContact: View {
    
    @State var name: String = ""
    @State var surname: String = ""
    @State var howYouMet: String = ""
    @State var relationship: String = ""
    @State var info: String = ""
    @State var helptoremember: String = ""
  
   
    
    var add: (_ contact: Contact) -> Void
    
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationStack {
          
            
            ZStack{
                Image(.oval)
                Image(systemName: "person.fill")
                    .foregroundStyle(Color.black)
                    .font(.system(size:20))
            }

            
            Form {
                
                Section("Name"){
                    TextField("", text: $name)
                    
                }
                Section("Surname") {
                    TextField("", text: $surname)
                }
                Section("How you met") {
                    TextField("", text: $howYouMet)
                }
                Section("Relationship") {
                    TextField("", text: $relationship)
                }
                Section("Info") {
                    TextField("", text: $info)
                }
                Section("Help to remember") {
                    TextField("", text: $helptoremember)
                }

               
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        showModal.toggle()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        let newContact = Contact(name: name, surname: surname, howYouMet: howYouMet, relationship: relationship, info: info, helpToRemember: helptoremember)
                        add(newContact)
                        showModal.toggle()
                    }
                }
            }
            .navigationTitle("New Contact")
            .preferredColorScheme(.dark)
            
        }
    }
}

#Preview {
    AddNewContact(add: { contact in
        
    }, showModal: .constant(true))
}


