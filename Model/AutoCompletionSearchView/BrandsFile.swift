//
//  BrandsFile.swift
//  Shoosen
//
//  Created by Manne Sahlin on 2022-01-28.
//

import Foundation
import Firebase


struct BrandsFile: BrandsSource {
    
    let location: URL
    var db = Firestore.firestore()

    
    init(location: URL){
        self.location = location
    }
    
    init?() {
    guard let location = Bundle.main.url(forResource: "brands", withExtension: "txt") else {
        assertionFailure("brands file is not in the main bundle")
            return nil
    }
 
        self.init(location: location)
        
    }
    func loadBrands() -> [String] {
        do {
            let data = try Data(contentsOf: location)
            let string = String(data: data, encoding: .utf8)
            return string?.components(separatedBy: .newlines) ?? []
        }
        catch {
            return []
        }
    }
}
