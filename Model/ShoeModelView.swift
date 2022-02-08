//
//  ShoeModelView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-25.
//

import Foundation
import Firebase


class ShoeModelView: ObservableObject {
    
    
    private var db = Firestore.firestore()
    private var auth = Auth.auth()
    
    
    
    
    func saveToFirestore(shoe: Shoe) {
        guard let uid = auth.currentUser?.uid else {return}
        if let shoeId = shoe.id {
            do {
                // if let shoe.id
                _ = try db.collection("UserCollection").document(uid).collection("favorites").document(shoeId).setData(["favorite" : shoeId])
                
            } catch {
                print("Error saving to DB")
            }
        }
        
       // db.collection("tmp").addDocument(data: ["name" : "David"])
    }
    
    

    
}
