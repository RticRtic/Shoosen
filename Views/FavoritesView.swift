//
//  FavoritesView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase

struct FavoritesView: View {
    
    var favoriteShoeImage: Shoe
    @State var favorite = [Shoe]()
    //@State var userCollection = [UserCollection]()
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                ScrollView {
                    HStack {
                        
                            ForEach(favorite) { shoe in
                                AsyncImage(url: URL(string: shoe.image)) {image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                    
                                } placeholder: {
                                    Image(systemName: "photo")
                                }
                            }
                    }
                }
            } .onAppear {
                
                getMultiple()
                
                
            } .onDisappear {
                favorite.removeAll()
            }
            
            
            .navigationTitle("Favorites")
            
        }
        .navigationViewStyle(.stack)
        
    }
    
    
    func getMultiple() {
        guard let uid = auth.currentUser?.uid else {return}
        var favoritesId: [String] = []
        
        db.collection("UserCollection").document(uid).collection("favorites")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Could not find document: \(err)")
                    //                    db.collection("UserCollection").document(uid).collection("favorites").addDocument(data: ["favorite" : shoe.id])
                } else {
                    favoritesId.removeAll()
                    for document in querySnapshot!.documents {
                        if let data = document.data() as? [String: String] {
                            if let id = data["favorite"] {
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
                                    favorite.append(shoe)
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
    
//    func getMultiple() {
//        db.collection("Shoes").whereField("brand", isEqualTo: brandName.brandname)
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Could not find document: \(err)")
//
//                } else {
//                    shoes.removeAll()
//                    for document in querySnapshot!.documents {
//                        let result = Result {
//                            try document.data(as: Shoe.self)
//                        }
//                        switch result {
//                        case .success(let shoe):
//                            if let shoe = shoe {
//                                shoes.append(shoe)
//                                print("SHOE: \(shoe)")
//                            } else {
//                                print("Error to get document")
//                            }
//                        case .failure(let error):
//                            print("Error \(error)")
//                        }
//                    }
//                }
//
//            }
//
//    }

    
    
    
//    func listenToFireStore() {
//        guard let uid = auth.currentUser?.uid else {return}
//        db.collection("UserCollection").document(uid).collection("favorites").addSnapshotListener { snapshot, err in
//            guard let snapshot = snapshot else {return}
//            
//            if let err = err {
//                
//                print("Could not find document: \(err)")
//                
//            } else {
//                userCollection.removeAll()
//                for document in snapshot.documents {
//                    let result = Result {
//                        try document.data(as: UserCollection.self)
//                    }
//                    switch result {
//                    case.success(let favoriteShoe):
//                        
//                        if let favoriteShoe = favoriteShoe {
//                            print("FAVORITE SHOEVIEW: \(favoriteShoe)")
//                            print("-----------------")
//                            print("USER: \(uid)")
//                            userCollection.append(favoriteShoe)
//                            
//                        } else {
//                            print("Document does not exist")
//                        }
//                    case.failure(let error):
//                        print("Error decoding Favorite: \(error)")
//                    }
//                }
//            }
//        }
//    }
}

//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView(favoriteShoeImage: Shoe(id: "", brand: "", color: "", shoetype: "", price: 0, size: 0, image: "", brandlogo: "", showshoe: false))
//    }
//}
