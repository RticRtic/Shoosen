//
//  HomeView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    private var db = Firestore.firestore()
    private var auth = Auth.auth()
    
    @State var contacts = [UserCollection]()
    @State var shoeIntrestImage = [Shoe]()
    
    let columns = [
        GridItem(.adaptive(minimum: 150)),
       
    ]
    
    //@State var userContacts: UserCollection
    
    var body: some View {
        
        VStack {
            Text("SellView")
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(shoeIntrestImage) { shoe in
                        AsyncImage(url: URL(string: shoe.image)) { image in
                                image
                                .resizable()
                                .scaledToFit()
                                

                                
                            } placeholder: {
                                Image(systemName: "photo")
                            }
                            .listRowBackground(Color(UIColor(named: "SecondBackground")!))
                    }
                    
                }
                
            }
            
            
            
            
        }
        .onAppear{
            //getBuyerInformation()
            getFavorite()
        }
        .background(Color(UIColor(named: "Background")!))

        
        
        
        
        
    }
    
    func getFavorite() {
       // favorite.removeAll()
        guard let uid = auth.currentUser?.uid else {return}
        var favoritesId: [String] = []
        
        db.collection("UserCollection").document(uid).collection("buyingProposal")
            .addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Could not find document: \(err)")
                    //db.collection("UserCollection").document(uid).collection("favorites").addDocument(data: ["favorite" : shoe.id])
                } else {

                    for document in querySnapshot!.documents {
                        if let data = document.data() as? [String: String] {
                            if let id = data["shoeId"] {
                                favoritesId.append(id)
                                print(favoritesId[0])
                            }
                            
                        }
                        
                    }
                    for id in favoritesId {
                        db.collection("Shoes").document(id).getDocument() {
                            (document, err) in


                            let result = Result {
                                try document?.data(as: Shoe.self)
                            }

                            switch result {
                            case .success(let shoe):
                                if let shoe = shoe {
                                    shoeIntrestImage.append(shoe)
                                    print("FAVORITE SHOE: \(shoe)")

                                } else {
                                    print("document does not exist")
                                }
                            case .failure(let error):
                                print("ERROR: \(error)")
                            }

                        }
                    }
                    
                }
                
            }
        
    }
        
//        func getBuyerInformation() {
//            guard let uid = auth.currentUser?.uid else {return}
//            var shoesForSale: [String] = []
//            db.collection("UserCollection").document(uid).collection("buyingProposal").addSnapshotListener() {snapshot, err in
//                guard let snapshot = snapshot else {return}
//                if let err = err {
//                    print("Could not find document: \(err)")
//
//                } else {
//                    for document in snapshot.documents {
//                        let result = Result {
//                            try document.data(as: UserCollection.self)
//
//                        }
//                        switch result {
//                        case .success(let contact):
//                            if let contact = contact {
//                                print(contact)
//
//                            }
//                        case .failure(let error):
//                            print("Error decoding contacts: \(error)")
//                        }
//                    }
//                }
//            }
//
//
//        }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

