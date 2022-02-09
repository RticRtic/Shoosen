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
    
    //@Published var shoes = [Shoe]()
    
    
    
    
    func saveToFirestore(shoe: Shoe) {
        print("savetofirestore")
        guard let uid = auth.currentUser?.uid else {return}
        if let shoeId = shoe.id {
            do {
                // if let shoe.id
                print("HEJ!!!!")
                _ = try db.collection("UserCollection").document(uid).collection("favorites").document(shoeId).setData(["favorite" : shoeId])
                
            } catch {
                print("Error saving to FB")
            }
        }
        
    }
    
    
}
