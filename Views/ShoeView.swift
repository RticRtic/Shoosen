//
//  ShoeView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-12.
//

import SwiftUI
import Firebase



struct ShoeView: View {
    

    var selectedShoe: Shoe
    //@State var shoeId = [Shoe]()
    @State var showingOptions = false
    @State var isShowingFavoriteView = false
    @StateObject var viewModel = ShoeModelView()
    @Environment(\.dismiss) var dismiss

    
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    
    
    var body: some View {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: brandInfo.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                        
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                        
                        

                        NavigationLink(destination: FavoritesView(), isActive: $isShowingFavoriteView) {
                            Button(action: {
                                // Kolla att skon inte redan ligger i favorites
                                viewModel.saveToFirestore(shoe: selectedShoe)
                                showingOptions = true
                                
                            }, label: {
                                VStack {
                                    Text("Add to Favorite")
                                        .foregroundColor(.black)
                                        .bold()
                                    
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                    
                                }
                                
                                
                                
                            })
                        }
                        .padding(.leading)
                        .actionSheet(isPresented: $showingOptions) {
                            ActionSheet(title: Text("Added to favorites"), buttons: [
                                .default(Text("Checkout your favorites")) {
                                    isShowingFavoriteView = true
                                },
                                .default(Text("Continue shopping")) {
                                    dismiss()
                                }])
                        }

                        
                        
                    }
                    
                    
                    VStack(spacing: 30) {
                        HStack {
                            Text(brandInfo.brand.uppercased())
                                .font(.largeTitle)
                                .bold()
                                .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                            
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                            
                            NavigationLink(destination: FavoritesView(favoriteShoeImage: brandInfo),isActive: $isShowingFavoriteView) {
                                
                                Button(action: {
                                    viewModel.saveToFirestore(shoe: brandInfo)
                                    print("Saving")
                                    isShowingFavoriteView = true
                                    
                                }, label: {
                                    VStack {
                                        Text("Add to Favorite")
                                            .foregroundColor(.black)
                                            .bold()
                                        
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                            
                                    }
                                    
                                        
                                    
                                })
                                        .padding(.leading)
                                
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Color: ")
                                    .font(.headline)
                                    .bold()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                    .padding()
                                
                                Text(brandInfo.color.uppercased())
                                    .font(.headline)
                                
                            }
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Shoetype: ")
                                        .font(.headline)
                                        .bold()
                                        .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                    
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                        .padding()
                                    
                                    
                                    Text(brandInfo.shoetype.uppercased())
                                        .font(.headline)
                                }
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Size:")
                                            .font(.headline)
                                            .bold()
                                            .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                        
                                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                            .padding()
                                        
                                        
                                        Text("\(brandInfo.size)")
                                            .font(.headline)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Price:")
                                                .font(.headline)
                                                .bold()
                                                .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                            
                                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                                .padding()
                                            
                                            
                                            Text("\(brandInfo.price):-")
                                                .font(.headline)
                                            
                                        }
                                    }
                                }
                            }
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    Button(action: {
                        print("Contacting seller")
                    }, label: {
                        Text("Buy!")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(Color.gray)
                            .cornerRadius(15)
                            .shadow(color: .white, radius: 10, x: 3, y: 3)
                            .padding(25)
                    })
                    
                        
                }
                .background(.white)
                //.cornerRadius(30)
                
                
            }
            

        }.onAppear{
            print(selectedShoe.id!)
        }//.onAppear
        
        .ignoresSafeArea(.container, edges: .top)
        
    }
//    func getMultiple() {
//        guard let uid = auth.currentUser?.uid else {return}
//        var favoritesId: [String] = []
//
//        db.collection("UserCollection").document(uid).collection("favorites")
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Could not find document: \(err)")
//                    //                    db.collection("UserCollection").document(uid).collection("favorites").addDocument(data: ["favorite" : shoe.id])
//                } else {
//                    //favoritesId.removeAll()
//                    for document in querySnapshot!.documents {
//                        if let data = document.data() as? [String: String] {
//                            if let id = data["favorite"] {
//                                favoritesId.append(id)
//                                print(favoritesId[0])
//                            }
//
//                        }
//
//                    }
//                    for id in favoritesId {
//                        db.collection("Shoes").document(id).getDocument() {
//                            (document, err) in
//
//
//                            let result = Result {
//                                try document?.data(as: Shoe.self)
//                            }
//
//                            switch result {
//                            case .success(let shoe):
//                                if let shoe = shoe {
//                                    shoeId.append(shoe)
//                                    print("FAVORITE SHOE: \(shoe)")
//
//                                } else {
//                                    print("document does not exist")
//                                }
//                            case .failure(let error):
//                                print("ERROR: \(error)")
//                            }
//
//                        }
//                    }
//
//                }
//
//            }
        
        
        
        
        
        
        //    func toggle(shoe: Shoe) {
        //        if let id = brandInfo.id {
        //            guard let uid = auth.currentUser?.uid else {return}
        //            db.collection("Shoes").document(uid).collection(brandInfo.brand).document(id)
        //            .updateData(["addtofavorite" : !brandInfo.addtofavorite ] )
        //        }
        //    }
        
        
        
        
        
    }



struct ShoeView_Previews: PreviewProvider {
    static var previews: some View {
        ShoeView(brandInfo: Shoe(id: "", brand: "birkenstock", color: "green", shoetype: "sandal", price: 110, size: 41, image: "https://firebasestorage.googleapis.com/v0/b/shoosen-413a3.appspot.com/o/Default%20Pictures%2Fbirkenstock_green.jpeg?alt=media&token=fca4a817-8a74-4b50-9dda-285d89967616", brandlogo: "", showshoe: false))
    }
}
