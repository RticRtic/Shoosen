//
//  TapBar.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI

struct TapBar: View {
    
    
    var body: some View {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                CategoryView()
                    .tabItem {
                        Label("Brands", systemImage: "square.fill.text.grid.1x2")
                    }
                FavoritesView(favoriteShoeImage: Shoe(id: "", brand: "", color: "", shoetype: "", price: 0, size: 0, image: "", brandlogo: "", showshoe: false))
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                SellShoeView()
                    .tabItem {
                        Label("Sell", systemImage: "dollarsign.circle")
                    }
                SignOut()
                    .tabItem{
                        Label("Settings", systemImage: "filemenu.and.cursorarrow")
                    }
            }
        
    }
}

struct TapBar_Previews: PreviewProvider {
    static var previews: some View {
        TapBar()
    }
}
