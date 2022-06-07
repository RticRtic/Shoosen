//
//  contactSeller.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-02-17.
//

import Foundation
import FirebaseFirestoreSwift

struct ContactSellers: Codable, Identifiable {
    @DocumentID var id: String?
    let seller: String
    let shoe: String
}
