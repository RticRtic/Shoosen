//
//  TapBar.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-10.
//

import SwiftUI
import Firebase

struct TapBar: View {
    @StateObject var viewModel = ShoeModelView()
    @State var changeColor = false
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    
    //var selectedShoe: Shoe
    
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    if changeColor {
                        Label("New Shoe!", systemImage: "star")
                            .background(Color.green)
                        
                    } else {
                        Label("Home", systemImage: "house")
                            .foregroundColor(.green)
                        
                    }
                }
            CategoryView()
                .tabItem {
                    Label("Brands", systemImage: "square.fill.text.grid.1x2")
                }
            FavoritesView()
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
        .onAppear{
            
            listenIfChecked()
        }
        
    }
    
    func listenIfChecked() {
        guard let uid = auth.currentUser?.uid else {return}
        db.collection("UserCollection").document(uid).collection("buyingProposal").addSnapshotListener() {(querySnapshot, err) in
            if let err = err {
                print("Can not find document!: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    if let data = document.data() as? [String : Any] {
                        if let checked = data["checked"] as? Bool {
                            
                            print("ööÖÖ: \(checked)")
                            if !checked {
                                changeColor = true
                                return
                            }
                            
                        }
                    }
                    
                    changeColor = false
                    
                    
                    
                }
            }
        }
        
        
        
    }
}

//struct TapBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TapBar()
//    }
//}
