//
//  UserCollection.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-26.
//

import Foundation
import FirebaseFirestoreSwift

struct UserCollection: Codable, Identifiable {
    @DocumentID var id: String?
    //let favorite: String
    let buyerEmail: String
    let buyerUid: String
    let shoeId: String

    var checked: Bool = false
    //var isContacted: Bool = false
    //var image: String


}
