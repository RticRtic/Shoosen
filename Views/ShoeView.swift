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
    @State var showingOptions = false
    @State var isShowingFavoriteView = false
    @State var showingAlert = false
    @Environment(\.dismiss) var dismiss
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    @StateObject var viewModel = ShoeModelView()
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: selectedShoe.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                    
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                    
                    
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
                        Text(selectedShoe.brand.uppercased())
                            .font(.largeTitle)
                            .bold()
                            .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                        
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                        
                        
                        NavigationLink(destination: FavoritesView(), isActive: $isShowingFavoriteView) {
                            Button(action: {
                                
                                compareShoeId(shoe: selectedShoe)
                                
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
                                .default(Text("Check out your favorites")) {
                                    isShowingFavoriteView = true
                                },
                                .default(Text("Continue shopping")) {
                                    dismiss()
                                }])
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Ops.."), message: Text("Shoe already exist in favorites"), dismissButton: .default(Text("Got it!")))
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
                            
                            Text(selectedShoe.color.uppercased())
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
                                
                                
                                Text(selectedShoe.shoetype.uppercased())
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
                                    
                                    
                                    Text("\(selectedShoe.size)")
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
                                        
                                        
                                        Text("\(selectedShoe.price):-")
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
            
            
        }.onAppear{
            //compareShoeId(shoe: selectedShoe)
        }
        
        .ignoresSafeArea(.container, edges: .top)
        
    }
    
    
    
    func compareShoeId(shoe: Shoe) {
        guard let uid = auth.currentUser?.uid else {return}
        if let shoeId = shoe.id {
            db.collection("UserCollection").document(uid).collection("favorites").getDocuments() {(querySnapShot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var alreadyExist = false
                    for document in querySnapShot!.documents {
                       
                        if document.documentID == shoeId {
                            alreadyExist = true
                            showingAlert = true
                            print("not possible")
                            
                        }
                        
                        if !alreadyExist {
                            viewModel.saveToFirestore(shoe: selectedShoe)
                            showingOptions = true
                        }
                    }
                }
            }
            
            
        }
        
        
        
        
    }
//    func showAlert() {
//        @State var showingAlert = false
//        Button("") {
//            showingAlert = true
//        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("Ops.."), message: Text("The shoe already exsist in your favorites"), dismissButton: .default(Text("Got it!")))
//        }
//    }
}









struct ShoeView_Previews: PreviewProvider {
    static var previews: some View {
        ShoeView(selectedShoe: Shoe(id: "", brand: "birkenstock", color: "green", shoetype: "sandal", price: 110, size: 41, image: "https://firebasestorage.googleapis.com/v0/b/shoosen-413a3.appspot.com/o/Default%20Pictures%2Fbirkenstock_green.jpeg?alt=media&token=fca4a817-8a74-4b50-9dda-285d89967616", brandlogo: "", showshoe: false))
    }
}
