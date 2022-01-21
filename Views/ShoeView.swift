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
    //var db = Firebase.
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: brandInfo.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                        
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(.white.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    
                    
                }
                
                
            }
            .ignoresSafeArea(.container, edges: .top)
            
        }
        
    }
    
    func listenToFireStore() {
    
        db.collection("Shoes").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
    
            if let err = err {
    
                print("Could not find document: \(err)")
    
            } else {
                shoes.removeAll()
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: Shoe.self)
                    }
                    switch result {
                    case.success(let shoe):
    
                        if let shoe = shoe {
                            print("Shoe: \(shoe)")
                            shoes.append(shoe)
    
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
    
}

struct ShoeView_Previews: PreviewProvider {
    static var previews: some View {
        ShoeView(brandInfo: Shoe(id: "", brand: "birkenstock", color: "", shoetype: "", price: 100, size: 21, image: "https://firebasestorage.googleapis.com/v0/b/shoosen-413a3.appspot.com/o/Default%20Pictures%2Fbirkenstock_green.jpeg?alt=media&token=fca4a817-8a74-4b50-9dda-285d89967616", brandlogo: "", showshoe: true))
    }
}
