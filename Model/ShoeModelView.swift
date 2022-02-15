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
    
    @Published var newShoeAdded = [UserCollection]()
    
    
    func buyingProposal(shoe: Shoe){
        guard let uid = auth.currentUser?.uid else {return}
        guard let uidEmail = auth.currentUser?.email else {return}
        if let shoeId = shoe.id {
            db.collection("Shoes").whereField("currentSeller", isEqualTo: shoe.currentSeller).getDocuments() {(querySnapshot, err) in
                if let err = err {
                    print("Cant get document: \(err)")
                    
                } else {
                    print(shoe.currentSeller)
                    do {

                        let buyingInfo = UserCollection(buyerEmail: uidEmail, buyerUid: uid, shoeId: shoeId)
                        _ = try
                       self.db.collection("UserCollection").document(shoe.currentSeller).collection("buyingProposal").document(shoeId).setData(from: buyingInfo)
                        
                        

                        
                        //                            .setData(["buyerUid" : shoe.currentSeller], ["buyerEmail" : uid])
                        
                    } catch {
                        print("can not set to FB")
                    }
                    
                }
            }
            
            
        }
    }
    
    
    
    func saveToFirestore(shoe: Shoe) {
        print("savetofirestore")
        guard let uid = auth.currentUser?.uid else {return}
        if let shoeId = shoe.id {
            do {
                _ = try db.collection("UserCollection").document(uid).collection("favorites").document(shoeId).setData(["favorite" : shoeId])
                
            } catch {
                print("Error saving to FB")
            }
        }
        
    }
    
//    func listenToChangesInBuyingProposal() {
//        guard let uid = auth.currentUser?.uid else {return}
//        //var newBuyingProposalShoe: [String] = []
//        db.collection("UserCollection").document(uid).collection("buyingProposal").addSnapshotListener() {(querySnapshot, err) in
//            if let err = err {
//                print("Error getting document!!!!!!!!: \(err)")
//
//            } else {
//                print("It works!!!")
//
//                for document in querySnapshot!.documents {
//                    let result = Result {
//                        try document.data(as: UserCollection.self)
//
//                    }
//                    switch result {
//                    case .success(let newShoe):
//                        if let newShoe = newShoe {
//                            self.newShoeAdded.append(newShoe)
//                            print(newShoe)
//
//                        }
//                    case .failure(let error):
//                        print("Error decoding contacts: \(error)")
//                    }
//
//
//                }
//
//
//            }
//
//        }
//
//    }
}

    
    
    
