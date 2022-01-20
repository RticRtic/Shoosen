//
//  SearchView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase

struct SearchView: View {
    
    var db = Firestore.firestore()
   
    @State var shoes = [Shoe]()
    @State  var brandInput: String = ""
    @State var sizeInput : Int = 43
    @State var shoetypeInput : String = ""
    
 
    
   
    
    var body: some View {
        NavigationView {
        VStack{
            HStack{
                TextField(
                    "Search by brand",
                    text: $brandInput)
                Button(action: {sortByBrand()}, label: {Text("Search by brand")})
            }
            HStack{
            Group{
            TextField(
                "Search by size",
                value: $sizeInput , formatter: NumberFormatter())
                Button(action: {
                    sortBySize()
                }, label: {
                    Text("Search by size")
                })
            }
            }
            HStack{
                TextField(
                    "Search by shoetype",
                    text: $shoetypeInput)
                Button(action: {
                    sortByShoeType()
                }, label: {
                    Text("Search by shoetype")
                })
            }
            List {
            ForEach(shoes) { shoe in
                 
                 HStack {
                    
                if shoe.showshoe == true {
                    // Not done in long ways
                    NavigationLink(destination: ShoeCard()) {
                
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
            }
    
}.onAppear() {
    listenToFireStore()
                
                
            }
    }
                .navigationViewStyle(.stack)
        }
    
   
    
            
        
    func sortByBrand() {
    let brandinputprefix = brandInput.lowercased().prefix(3)
    
    for var shoe in shoes {
    
        if shoe.brand.hasPrefix(brandinputprefix) {
            shoe.showshoe = true
         
            
            print("\(shoe.brand) = \(shoe.showshoe)")
        }
    }
        
}
    
    func sortBySize() {
        
        for var shoe in shoes {
           
            if sizeInput == shoe.size {
                shoe.showshoe = true
                print("\(shoe.brand) = \(shoe.showshoe)")
                listenToFireStore()
            }
            }
    
    }

    func sortByShoeType(){
        
        let shoetypeInputPrefix = shoetypeInput.lowercased().prefix(3)
        
        for var shoe in shoes {
        
            if shoe.shoetype.hasPrefix(shoetypeInputPrefix) {
                shoe.showshoe = true
                print("\(shoe.brand) = \(shoe.showshoe)")
        }
    }
      
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
