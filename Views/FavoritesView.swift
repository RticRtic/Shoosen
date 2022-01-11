//
//  FavoritesView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationView {
        Text("Favorites")
                .navigationTitle("Favorites")
    }
        .navigationViewStyle(.stack)
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
