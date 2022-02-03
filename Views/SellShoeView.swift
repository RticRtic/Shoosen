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
    
    
    var body: some View {
        
        
        
        
        
        
        
        
        
        
        
        
        
        Button("Sell shoe"){
            showSheet = true
        }
        .foregroundColor(.white)
        
        .frame(width: 200, height: 40)
        .background(Color.gray)
        .cornerRadius(15)
        .shadow(color: .white, radius: 10, x: 3, y: 3)
        .padding(80)
        
        .sheet(isPresented: $showSheet, content: {
            SellShoeSheetView()
            
        } )
    }
}

struct SellShoeView_Previews: PreviewProvider {
    static var previews: some View {
        SellShoeView()
    }
}

