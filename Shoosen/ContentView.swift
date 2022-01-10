//
//  ContentView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-07.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    var db = Firestore.firestore()
    @State var shoes = [Shoe]()
    
    var body: some View {
        
        
        
        VStack {
            
            List {
                
                ForEach(shoes) { shoe in
                    HStack {
                        Text(shoe.brand)
                        Spacer()
                        Button {
                            if let id = shoe.id {
                                db.collection("Shoes").document(id)
                            }
                        } label: {
                            Image(systemName: "square")
                        }

                        
                    }
                    
                }
            
            
        }
            Button {
                saveToFireBase()
            } label: {
                Text("Save")
            }
            .onAppear() {
                listenToFireStore()
            }
            
        }
        
        
    }
    
    func saveToFireBase() {
        db.collection("Shoes").addDocument(data: ["brand" : "adidas"])
        
    }
    
    func listenToFireStore() {
        
        db.collection("Shoes").addSnapshotListener { snapshot, err in
            
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Could not find document: \(err)")
                
            } else {
                shoes.removeAll()
                    
                    for document in snapshot.documents {
                        let result = Result {
                            try document.data(as: Shoe.self)
                            
                        }
                        switch result {
                        case.success(let shoe):
                            if let shoe = shoe {
                                print("Shoe: \(shoe)")
                                shoes.append(shoe)
                            } else {
                                print("Document does not exist")
                            }
                        case.failure(let error):
                            print("Error decoding shoe \(error)")
                        }
                    }
                    
                
            }
            
        }
        
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
