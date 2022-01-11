//
//  SearchView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView {
            Text("Search shoe")
                .navigationTitle("Search Shoe/s")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
