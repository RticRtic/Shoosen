//
//  SignIn.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-12.
//

import Foundation
import FirebaseAuth


class SignIn: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {

        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {return}
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {return}
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
        
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    
}
