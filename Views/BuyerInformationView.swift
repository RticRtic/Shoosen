//
//  BuyerInformationView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-02-10.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct BuyerInformationView: View {
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    @State var contacts = [UserCollection]()
    var reciveBuyerInformation: Shoe
    
    
    var body: some View {
        VStack {
            List {
                ForEach(contacts) {contact in
                    if contact.shoeId == reciveBuyerInformation.id {
                        Text(contact.buyerEmail)
                    }
                    
                }
            }
        }
        .onAppear{
            getBuyerInformation(shoe: reciveBuyerInformation)
        }
    }
    
    func getBuyerInformation(shoe: Shoe) {
        guard let uid = auth.currentUser?.uid else {return}
        contacts.removeAll()
        db.collection("UserCollection").document(uid).collection("buyingProposal").addSnapshotListener() {snapshot, err in
            guard let snapshot = snapshot else {return}
            if let err = err {
                print("Could not find document: \(err)")

            } else {
                for document in snapshot.documents {
                    let result = Result {
                        try document.data(as: UserCollection.self)

                    }
                    switch result {
                    case .success(let contact):
                        if let contact = contact {
                            contacts.append(contact)
                            print(contact)

                        }
                    case .failure(let error):
                        print("Error decoding contacts: \(error)")
                    }
                }
            }
        }


    }
    
}

