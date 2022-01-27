//
//  ShoeView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-12.
//

import SwiftUI
import Firebase



struct ShoeView: View {
    
    var brandInfo: Shoe
    @State var userCollection = [UserCollection]()
    @State var isShowingFavoriteView = false
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    @StateObject var viewModel = ShoeModelView()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: brandInfo.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
//                            .scaledToFit()
//                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        
                        
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(.white.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        
                    }
                    
                    
                    VStack(spacing: 30) {
                        HStack {
                            Text(brandInfo.brand.uppercased())
                                .font(.largeTitle)
                                .bold()
                                .background()
                                .cornerRadius(5)
                                .shadow(color: .black, radius: 3, x: 3, y: 3)
                                .multilineTextAlignment(.center)
                                .shadow(color: .black, radius: 3, x: 3, y: 3)
                            
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
                                    .multilineTextAlignment(.center)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .shadow(color: .black, radius: 3, x: 3, y: 3)
                                    .padding()
                                
                                Text(brandInfo.color.uppercased())
                                    .font(.headline)
                                
                            }
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Shoetype: ")
                                        .font(.headline)
                                        .bold()
                                        .background(.white)
                                        .cornerRadius(5)
                                        .multilineTextAlignment(.center)
                                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                                        .padding()
                                    
                                    
                                    Text(brandInfo.shoetype.uppercased())
                                        .font(.headline)
                                }
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Size:")
                                            .font(.headline)
                                            .bold()
                                            .background(.white)
                                            .cornerRadius(5)
                                            .multilineTextAlignment(.center)
                                            .shadow(color: .black, radius: 3, x: 3, y: 3)
                                            .padding()
                                        
                                        
                                        Text("\(brandInfo.size)")
                                            .font(.headline)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Price:")
                                                .font(.headline)
                                                .bold()
                                                .background(.white)
                                                .cornerRadius(5)
                                                .multilineTextAlignment(.center)
                                                .shadow(color: .black, radius: 3, x: 3, y: 3)
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
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .background(.brown)
                //.cornerRadius(30)
                
                
            }
            
            .ignoresSafeArea(.container, edges: .top)
        
        }
        .navigationViewStyle(.stack)
  
        
        
        
    }

    
    
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
