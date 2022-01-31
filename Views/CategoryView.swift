//
//  CategoryView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase




struct CategoryView: View {
    
    var db = Firestore.firestore()
    @State var brandLogos = [BrandLogo]()
    
    var body: some View {
        
        VStack {
            List {
                ForEach(brandLogos) { logo in
                    NavigationLink(destination: ShoeCard(brandName: logo)) {
                        AsyncImage(url: URL(string: logo.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                            
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                            
                            
                            
                        } placeholder: {
                            Image(systemName: "photo")
                        }
                        
                    }
                    
                }
            }
            .onAppear() {
                listenToFireStore()
                
            }
            
            
            
            .navigationViewStyle(.stack)
        } 
        
        
        
        
        
        
        
    }
    
    func listenToFireStore() {
        
        db.collection("BrandLogos").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                
                print("Could not find document: \(err)")
                
            } else {
                brandLogos.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: BrandLogo.self)
                    }
                    switch result {
                    case.success(let brandLogo):
                        
                        if let brandLogo = brandLogo {
                            print("BrandLogos: \(brandLogo)")
                            brandLogos.append(brandLogo)
                            
                        } else {
                            print("Document does not exist")
                        }
                    case.failure(let error):
                        print("Error decoding brandLogos \(error)")
                    }
                }
            }
        }
    }
    
    //    func getMultiple() {
    //        db.collection("Shoes").whereField("brand", isEqualTo: "adidas")
    //            .getDocuments() { (querySnapshot, err) in
    //                //guard let querySnaphot = querySnapshot else {return}
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
    //                                print("A D I D A S \(shoe)")
    ////                                let addShoe = Shoe(id:shoe.id, brand: shoe.brand, color: shoe.color, shoetype: shoe.shoetype, price: shoe.price, size: shoe.price, image: shoe.image, brandlogo: shoe.brandlogo, showshoe: shoe.showshoe)
    ////                                shoes.append(addShoe)
    //                                //print("A D I D A S shoe is in the newlist: \(addShoe)")
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
    //
    //    }
    
    
    //    func getMultiple() {
    //        db.collection("Shoes").whereField("brand", isEqualTo: "adidas")
    //            .getDocuments() { (querySnapshot, err) in
    //                if let err = err {
    //                    print("Error getting documents: \(err)")
    //                } else {
    //                    for document in querySnapshot!.documents {
    //                        print("SHOE!: \(document.documentID) => \(document.data())")
    //                    }
    //
    //                }
    //            }
    //
    //    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}



