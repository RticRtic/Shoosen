//
//  Shoe.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import Foundation
import FirebaseFirestoreSwift

struct Shoe: Identifiable, Codable {
    @DocumentID var id: String?
    
    let brand: String
    let color: String
    let shoeType: String
    let price: Int
    let size: Int
    var image: String
    let brandLogo: String

    var showShoe: Bool
    var currentSeller: String



}

