//
//  ShoosenApp.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-07.
//

import SwiftUI
import Firebase

@main
struct ShoosenApp: App {
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
