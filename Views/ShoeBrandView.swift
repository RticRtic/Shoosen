//
//  ShoeCard.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-11.
//

import SwiftUI
import Firebase

struct ShoeBrandView: View {
    
    var db = Firestore.firestore()
    
    @State var shoes = [Shoe]()
    @State var brandName: BrandLogo
    
    var body: some View {
        VStack {
            List {
                ForEach(shoes) { shoe in
                    NavigationLink(destination: ShoeView(selectedShoe: shoe)) {
                        AsyncImage(url: URL(string: shoe.image)) { image in
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
                    
                    .listRowBackground(Color(UIColor(named: "SecondBackground")!))
                }
                
                
                
            } .onAppear {
                getMultiple()
            }
            
           
            .background(Color(UIColor(named: "Background")!))
        }
        
    
        
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

struct ShoeCard_Previews: PreviewProvider {
    static var previews: some View {
        ShoeBrandView(brandName: BrandLogo.init(id: "", brandname: "birkenstock", image: ""))
    }
}
