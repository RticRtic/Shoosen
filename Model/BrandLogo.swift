//
//  BrandLogo.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-12.
//

import Foundation
import FirebaseFirestoreSwift


struct BrandLogo: Identifiable {
    
    @DocumentID var id: String?
    let brandlogo: String
    
}
