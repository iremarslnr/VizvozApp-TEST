import SwiftUI

// Define a struct to represent a Contact


struct ContactPage: View {
    @State private var contacts: [Contact] = []
    @State private var showingAddContactView = false
    @State private var searchText = ""
    let imageNames = ["Oval", "Oval2", "Oval3", "Oval4", "Oval5"]

    var body: some View {
        
 
            VStack {
                HStack {
                    Image(.vizvoz)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    
                    Spacer()
                    
                    TextField("Search", text: $searchText)
                                        .padding(10)
                                        .background(Color.white.opacity(0.2))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                    Spacer()
                    
                    
                    Button {
                        showingAddContactView = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(Color.white)
                            .fixedSize()
                    }
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
                    if contacts.count == 0 {
                        VStack {
                            ContentUnavailableView {
                                Label("No Contacts", systemImage: "person.crop.circle.badge.xmark")
                        }  description: {
                                Text("New contacts that you add will appear here.")
                        } actions: {
                            Button {
                                showingAddContactView = true
                            } label: {
                                Text("Add your first contact")
                            }
                        }
                                .preferredColorScheme(.dark)
                            
                        
                           
                        }
                        .navigationTitle("Contacts")
                    } else {
                        List {
                            ForEach(contacts.indices, id: \.self) { index in
                                NavigationLink(destination: ContactDetailView(contact: $contacts[index])) {
                                    HStack {
                                        ZStack {
                                            let imageIndex = index % imageNames.count
                                            Image(imageNames[imageIndex])
                                            Text(String(contacts[index].name.prefix(2)))
                                                .foregroundStyle(Color.black)
                                                .font(.system(size: 20))
                                        }
                                        Text(contacts[index].name)
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
               
                       
                AddNewContact(add: {contact in 
                    contacts.append(contact)
                    }, showModal: $showingAddContactView)
 
            }
        }
    }

    private func deleteContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
    }
}


#Preview {
    ContactPage()
}
