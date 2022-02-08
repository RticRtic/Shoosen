//
//  SellShoeView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase
import FirebaseAuth



struct SellShoeView: View {
    
    @State private var showSheet = false
    var db = Firestore.firestore()
    var auth = Auth.auth()
    @State var shoes = [Shoe]()
    
    
    
    var body: some View {
        
        VStack {
        Button("Sell shoe"){
            showSheet = true
        }
        
        .foregroundColor(.white)
        
        .frame(width: 200, height: 40)
        .background(Color.gray)
        .cornerRadius(15)
        .shadow(color: .white, radius: 10, x: 3, y: 3)
        .padding(80)
        
        
            List {
                ForEach(shoes) { shoe in
                    
                    HStack {
                        NavigationLink(destination: ShoeView(selectedShoe: shoe)) {
                            AsyncImage(url: URL(string: shoe.image)) {image in
                                image
                                
                                    .resizable()
                                    .scaledToFit()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                                
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                                    .padding()
                                }
                            
                        
                        placeholder: {
                            Image(systemName: "photo")
                        }
                            
                            VStack {
                                Text(shoe.brand.uppercased())
                                    .padding()
                                    .font(.headline)
                                Text("\(shoe.price) Kr")
                                    .padding()
                                
                            }
                        }
                    }
                }
            }
        }

        .sheet(isPresented: $showSheet, content: {
            SellShoeSheetView()
            
        } )
        .onAppear() {
            getMyShoes()
        }
    }
    
    func getMyShoes() {
        
        shoes.removeAll()
        
        guard let uid = auth.currentUser?.uid else {return}
        
        var query = db.collection("Shoes").whereField("currentSeller", isEqualTo: uid)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let result = Result {
                        try document.data(as: Shoe.self)
                    }
                    switch result {
                    case .success(let shoe):
                        if let shoe = shoe {
                            shoes.append(shoe)
                            print("MY SHOES: \(shoe)")
                        } else {
                            print("Error to get document")
                        }
                    case .failure(let error):
                        print("Error \(error)")
                    }
                    
                }
               
            }
        }

        
        
        
        
    }
    
    
    
}

struct SellShoeView_Previews: PreviewProvider {
    static var previews: some View {
        SellShoeView()
    }
}

