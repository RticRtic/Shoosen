//
//  SellShoeView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase

struct SellShoeView: View {
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Sell shoe/s")
            }
            
            Button {
                saveToFireBase()
            } label: {
                Text("Save")
            }
            
            .navigationTitle("Sell Shoe/s")
            
        }
        .navigationViewStyle(.stack)
    }
    
    
    
    
    func saveToFireBase() {
        //db.collection("Shoes").addDocument(data: ["brand" : "adidas"])
        
    }
}

struct SellShoeView_Previews: PreviewProvider {
    static var previews: some View {
        SellShoeView()
    }
}
