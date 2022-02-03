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
        do {
            _ = try db.collection("UserCollection").document(uid).collection("favorites").addDocument(data: ["favorite" : shoe.id])
            
        } catch {
            print("Error saving to DB")
        }
       // db.collection("tmp").addDocument(data: ["name" : "David"])
    }
    
    

    
}
