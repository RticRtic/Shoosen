//
//  ContentView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-07.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    var db = Firestore.firestore()
    
    var body: some View {
        Button {
            saveToFireBase()
        } label: {
            Text("Save")
        }

    }
    
    func saveToFireBase() {
        db.collection("Name").addDocument(data: ["Name" : "Janne"])
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
