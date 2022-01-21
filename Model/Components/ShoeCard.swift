//
//  ShoeCard.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-11.
//

import SwiftUI
import Firebase

struct ShoeCard: View {
    
    var db = Firestore.firestore()
    
    @State var shoes = [Shoe]()
    @State var brandName: BrandLogo
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(shoes) { shoe in
                        HStack {
                            NavigationLink(destination: ShoeView(brandInfo: shoe)) {
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
                    getMultiple()
                }
                .ignoresSafeArea(.container, edges: .top)
            }
            
            
            //                                    .frame(width: 200, height: 217, alignment: .top)
            //                                    .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            //
            //                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            //                                    .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
            
            // Vill ha title efter brand
            .navigationTitle("")
           
        }
        .navigationViewStyle(.stack)
    }
    
    
    
    func getMultiple() {
        db.collection("Shoes").whereField("brand", isEqualTo: brandName.brandname)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Could not find document: \(err)")
                    
                } else {
                    shoes.removeAll()
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: Shoe.self)
                        }
                        switch result {
                        case .success(let shoe):
                            if let shoe = shoe {
                                shoes.append(shoe)
                                print("SHOE: \(shoe)")
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

//func listenToFireStore() {
//
//    db.collection("Shoes").addSnapshotListener { snapshot, err in
//        guard let snapshot = snapshot else {return}
//
//        if let err = err {
//
//            print("Could not find document: \(err)")
//
//        } else {
//            shoes.removeAll()
//            for document in snapshot.documents {
//                let result = Result {
//                    try document.data(as: Shoe.self)
//                }
//                switch result {
//                case.success(let shoe):
//
//                    if let shoe = shoe {
//                        print("Shoe: \(shoe)")
//                        shoes.append(shoe)
//
//                    } else {
//                        print("Document does not exist")
//                    }
//                case.failure(let error):
//                    print("Error decoding shoe \(error)")
//                }
//            }
//        }
//    }
//}

struct ShoeCard_Previews: PreviewProvider {
    static var previews: some View {
        ShoeCard(brandName: BrandLogo.init(id: "", brandname: "birkenstock", image: ""))
    }
}
