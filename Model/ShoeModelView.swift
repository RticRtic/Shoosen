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
        guard let uid = auth.currentUser?.uid else {return}
        if let shoeId = shoe.id {
            do {
                // if let shoe.id
                _ = try db.collection("UserCollection").document(uid).collection("favorites").document(shoeId).setData(["favorite" : shoeId])
                
            } catch {
                print("Error saving to FB")
            }
        }
        
       // db.collection("tmp").addDocument(data: ["name" : "David"])
    }
    
//    func toggle(favorite: Shoe) {
//        if let id = favorite.id {
//            guard let uid = auth.currentUser?.uid else {return}
//            db.collection("UserCollection").document(uid).collection("favorites").getDocuments() {(querySnapshot, err) in
//                if let err = err {
//                    print("Error getting id: \(err)")
//                    
//                } else {
//                    var isInFavorite = false
//                    for document in querySnapshot!.documents {
//                        if document.documentID == id {
//                            isInFavorite = true
//                            print(document.documentID)
//                            print("Exist in favorite: heart.fill")
//                        }
//                        if !isInFavorite {
//                            print("Not exist in favorite: heart")
//                        }
//                    }
//                }
//            }
//                
//        }
//    }
    
//    func compareShoeId(shoe: Shoe) {
//        guard let uid = auth.currentUser?.uid else {return}
//        if let shoeId = shoe.id {
//            db.collection("UserCollection").document(uid).collection("favorites").getDocuments() {(querySnapShot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    var alreadyExist = false
//                    for document in querySnapShot!.documents {
//
//                        if document.documentID == shoeId {
//                            alreadyExist = true
//                            showingAlert = true
//                            deleteShoe(shoe: selectedShoe)
//
//
//
//                        }
//
//                        if !alreadyExist {
//                            viewModel.saveToFirestore(shoe: selectedShoe)
//                            showingOptions = true
//
//
//
//                        }
//                    }
//                }
//            }
//
//
//        }
//
//
//
//
//
//    }
    

    
//    func toggle(item: Item) {
//        if let id = item.id {
//            guard let uid = auth.currentUser?.uid else {return}
//            db.collection("users").document(uid).collection("items").document(id)
//            .updateData(["done" : !item.done ] )
//        }
//    }
    
    

    
}
