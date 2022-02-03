//
//  FavoritesView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase


struct FavoritesView: View {
    
    @State var favorite = [Shoe]()
    @State var showingOptions = false
    @State var isShowingShoe = false
    @Environment(\.dismiss) var dismiss
    
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    let data = (1...100).map { "Shoe \($0)" }
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    var body: some View {
        
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
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
                                        HStack {
                                            Button(action: {
                                                showingOptions = true
                                                
                                            }, label: {
                                                Image(systemName: "trash.fill")
                                                    .foregroundColor(.black)
                                                    .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                                
                                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                            }) .padding()
                                            
                                                .actionSheet(isPresented: $showingOptions) {
                                                    ActionSheet(title: Text("Delete shoe?"), buttons: [
                                                        .default(Text("Yes")) {
                                                            deleteShoe(shoe: shoe)
                                                        },
                                                        .default(Text("No")) {
                                                            dismiss()
                                                        }])
                                                }
                                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        HStack {
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
                    //favoritesId.removeAll()
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
    
    
    
    func deleteShoe(shoe: Shoe) {
        guard let uid = auth.currentUser?.uid else {return}
        if let shoeId = shoe.id {
            db.collection("UserCollection").document(uid).collection("favorites").document(shoeId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
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

//struct SheetView: View {
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        Button("The shoe is not anymore in your favorites") {
//            dismiss()
//        }
//        .font(.largeTitle)
//        .foregroundColor(.black)
//        .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
//
//        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
//        .padding()
//    }
//}

