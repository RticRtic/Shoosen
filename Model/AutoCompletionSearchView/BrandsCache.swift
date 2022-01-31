//
//  BrandsCache.swift
//  Shoosen
//
//  Created by Manne Sahlin on 2022-01-28.
//

protocol BrandsSource {
    
    func loadBrands() -> [String]
    
}


actor BrandsCache {
    
    let source: BrandsSource
    
    init(source: BrandsSource) {
        self.source = source
    }
    
    var brands: [String]{
        if let brands = cachedBrands {
            return brands
        }
        
        let brands = source.loadBrands()
        cachedBrands = brands
        
        return brands
    }
    
    private var cachedBrands: [String]?
}

extension BrandsCache {
    func lookup(prefix: String) -> [String] {
        brands.filter { $0.hasCaseAndDiacriticInsensitivePrefix(prefix) }
    }
}
