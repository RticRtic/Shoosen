//
//  BrandLogo.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-12.
//

import Foundation
import FirebaseFirestoreSwift


struct BrandLogo: Identifiable, Codable {
    
    @DocumentID var id: String?
    let brandname: String
    let image: String
    
    
}
