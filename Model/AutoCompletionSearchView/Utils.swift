//
//  Utils.swift
//  Shoosen
//
//  Created by Manne Sahlin on 2022-01-28.
//

extension String {
    
    func hasCaseAndDiacriticInsensitivePrefix(_ prefix: String) -> Bool {
        guard let range = self.range(of: prefix, options: [.caseInsensitive, .diacriticInsensitive]) else {
            return false
        }
    
        return range.lowerBound == startIndex
    }
}
