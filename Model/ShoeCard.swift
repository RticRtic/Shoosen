//
//  ShoeCard.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-11.
//

import SwiftUI
import Firebase

struct ShoeCard: View {
    
    //var shoeInfo: Shoe? = nil
    
    var db = Firestore.firestore()
    @State var shoes: [Shoe]? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if let shoes = shoes {
                        ForEach(shoes) { shoe in
                            HStack {
                                AsyncImage(url: URL(string: shoe.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .aspectRatio(contentMode: .fill)
                                        .overlay(alignment: .bottom) {
                                            Text(shoe.brand)
                                                .font(.headline)
                                                .foregroundColor(.black)
                                                .shadow(color: .black, radius: 3, x: 0, y: 0)
                                                .frame(maxWidth: 136)
                                                .padding()
                                            
                                        }
                                    
                                } placeholder: {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40, alignment: .center)
                                        .foregroundColor(.white.opacity(0.7))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .overlay(alignment: .bottom) {
                                            Text(shoe.brand)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 3, x: 0, y: 0)
                                                .frame(maxWidth: 136)
                                                .padding()
                                        }
                                }
                                
                            }
                        }
                        
                    }
                    
                } .onAppear {
                    //listenToFireStore()
                    getMultiple()
                }
            }
            
            //            .frame(width: 200, height: 217, alignment: .top)
            //            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            //
            //            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            //            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
            //
            // Vill ha title efter brand
            //.navigationTitle((shoeInfo?.brand)!)
            
        }
        .navigationViewStyle(.stack)
    }
    
    
    func listenToFireStore() {
        
        db.collection("Shoes").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                
                print("Could not find document: \(err)")
                
            } else {
                shoes?.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: Shoe.self)
                    }
                    switch result {
                    case.success(let shoe):
                        
                        if let shoe = shoe {
                            print("Shoe: \(shoe)")
                            shoes?.append(shoe)
                            
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
    
    func getMultiple() {
        db.collection("Shoes").whereField("brand", isEqualTo: "adidas")
            .getDocuments() { (querySnapshot, err) in
                //guard let querySnaphot = querySnapshot else {return}
                if let err = err {
                    print("Could not find document: \(err)")
                    
                } else {
                    // shoes.removeAll()
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: Shoe.self)
                        }
                        switch result {
                        case .success(let shoe):
                            if let shoe = shoe {
                                shoes?.append(shoe)
                                print("A D I D A S \(shoe)")
                                //  let addShoe = Shoe(id:shoe.id, brand: shoe.brand, color: shoe.color, shoetype: shoe.shoetype, price: shoe.price, size: shoe.size, image: shoe.image, brandlogo: shoe.brandlogo, showshoe: shoe.showshoe)
                                //  shoes?.append(addShoe)
                                //  print("A D I D A S shoe is in the newlist: \(addShoe)")
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

//struct ShoeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoeCard()
//    }
//}
