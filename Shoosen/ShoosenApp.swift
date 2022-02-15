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
    
    
   @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    var selectedShoe: Shoe
    
   
//    init () {
//        FirebaseApp.configure()
//    
//    }
    
    var body: some Scene {
        WindowGroup {
            let signInModel = SignIn()
            ContentView()
                .environmentObject(signInModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

