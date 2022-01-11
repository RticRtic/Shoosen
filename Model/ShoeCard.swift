//
//  ShoeCard.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-11.
//

import SwiftUI

struct ShoeCard: View {
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle("Shoe info")
        }
        .navigationViewStyle(.stack)
    }
}

struct ShoeCard_Previews: PreviewProvider {
    static var previews: some View {
        ShoeCard()
    }
}
