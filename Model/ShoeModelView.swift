//
//  ShoeModelView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-25.
//

import Foundation
import Firebase
import SwiftUI


class ShoeModelView: ObservableObject {
    
    
    private var db = Firestore.firestore()
    private var auth = Auth.auth()
    
    @Published var newShoeAdded = [UserCollection]()
    
    func contactSeller(shoe: Shoe) {
        guard let uid = auth.currentUser?.uid else {return}
        guard let uidEmail = auth.currentUser?.email else {return}
        if let shoeId = shoe.id {
            db.collection("Shoes").whereField("currentSeller", isEqualTo: shoe.currentSeller).getDocuments() {(querySnapshot, err) in
                if let err = err {
                    print("can not find document: \(err)")
                    
                } else {
                    
                    do {
                        let buyingInfo = UserCollection(buyerEmail: uidEmail, buyerUid: uid, shoeId: shoeId)
                        _ = try
                        self.db.collection("UserCollection").document(shoe.currentSeller).collection("buyingProposal").document(shoeId).setData(from: buyingInfo)
                        
                        let sellerInfo = ContactSellers(id: uid, seller: shoe.currentSeller, shoe: shoeId)
                        _ = try
                        self.db.collection("UserCollection").document(shoe.currentSeller).collection("contactedSellers").document(shoeId).setData(from: sellerInfo)
                        print("!!!: \(sellerInfo)")
                        
                    } catch {
                        print("can not set to FB")
                    }
                    
                }
            }
        }
    }
    
    
    // took out the do catch
    func saveToFirestore(shoe: Shoe) {
        print("savetofirestore")
        guard let uid = auth.currentUser?.uid else {return}
        if let shoeId = shoe.id {
            db.collection("UserCollection").document(uid).collection("favorites").document(shoeId).setData(["favorite" : shoeId])
            
        }
        
    }
}




