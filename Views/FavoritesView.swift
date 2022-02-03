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

    @State var showingOptions = false
    @State var isShowingShoe = false
    @Environment(\.dismiss) var dismiss
    

    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    
    var body: some View {
        
        VStack {
            ScrollView {
                HStack {
                    ForEach(favorite) { shoe in
                        AsyncImage(url: URL(string: shoe.image)) {image in
                            image
                            
                                .resizable()
                                .scaledToFit()
                                .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                            
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                .padding()
                                .overlay {
                                    VStack(alignment: .trailing) {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Button(action: {

                                                // deleteShoe(shoe: shoe)
                                                showingOptions = true

                                                
                                            }, label: {
                                                Image(systemName: "trash.fill")
                                                    .foregroundColor(.black)
                                                    .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                                
                                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                            }) .padding()
                                        } .frame(width: 200, height: 200, alignment: .top)
                                    }
                                    HStack {
                                        NavigationLink(destination: ShoeView(), isActive: $isShowingShoe) {}
                                            Button(action: {
                                                // Skapa att man kommer tillbaka till den skons shoeView när man trycker på info
                                                
                                                if let shoeId = shoe.id {
                                                    if favorite.contains(where: {$0.id == shoeId}) {
                                                        isShowingShoe = true
                                                        print(shoeId)
                                                    }
                                                }
                                                print("To ShoeView")
                                            }, label: {
                                                Text("Info")
                                                    .font(.headline)
                                                    .foregroundColor(.black)
                                                    .shadow(color: .black, radius: 3, x: 0, y: 0)
                                                    .frame(maxWidth: 136)
                                            }).padding()
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                                }
                            
                            
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(favoriteShoeImage: Shoe(id: "", brand: "", color: "", shoetype: "", price: 0, size: 0, image: "https://firebasestorage.googleapis.com/v0/b/shoosen-413a3.appspot.com/o/Default%20Pictures%2Fbirkenstock_green.jpeg?alt=media&token=fca4a817-8a74-4b50-9dda-285d89967616", brandlogo: "", showshoe: false))
    }
}
