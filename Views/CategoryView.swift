//
//  CategoryView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase

struct CategoryView: View {
    
    var db = Firestore.firestore()
    @State var shoes = [Shoe]()
    //@State var brandLogos = [BrandLogo]()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(shoes) { shoe in
                        HStack {
                            // Problem att logon visas fler gånger
                            NavigationLink(destination: ShoeCard(shoeInfo: shoe)) {
                                AsyncImage(url: URL(string: shoe.brandlogo)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        
                                    
                                } placeholder: {
                                    Image(systemName: "photo")
                                }
                            }
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
                
                .onAppear() {
                    listenToFireStore()
                }
                .padding(.vertical)
                
            }
            .padding(.vertical)
            .navigationTitle("Brands")
        }
        .navigationViewStyle(.stack)
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


struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
