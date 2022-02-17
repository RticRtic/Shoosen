//
//  FavoritesView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase
import simd


struct FavoritesView: View {
    
    
    @State var favorite = [Shoe]()
    @State var isShowingDeleteOptions = false
    @State var isShowingShoe = false
    
    @Environment(\.dismiss) var dismiss
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    //let data = (1...20).map { "Shoe \($0)" }
    let columns = [
        GridItem(.adaptive(minimum: 150)),
       
    ]
    
    
    var body: some View {
        
        VStack {
            Text("FAVORITES")
                .font(.headline)
                .foregroundColor(.black)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(favorite) { shoe in
                        
                        NavigationLink(destination:ShoeView(selectedShoe: shoe)) {
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
                                            Text("\(shoe.price):-")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                                .padding()
                                        } .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                              
                                    }
                                
                            } placeholder: {
                                Image(systemName: "photo")
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } .onAppear {
            getFavorite()
            
            
        } .onDisappear {
            //favorite.removeAll()
        }
        .background(Color(UIColor(named: "Background")!))

        
    }

    
    
    func getFavorite() {
        favorite.removeAll()
        guard let uid = auth.currentUser?.uid else {return}
        var favoritesId: [String] = []
        
        db.collection("UserCollection").document(uid).collection("favorites")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Could not find document: \(err)")
                   
                } else {

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
}








struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}


