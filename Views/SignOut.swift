//
//  SignOut.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-28.
//

import SwiftUI


struct SignOut: View {
    @EnvironmentObject var signIn: SignIn
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        
        VStack {
        
            Toggle("Dark mode", isOn: $isDarkMode)
                .padding()
        
        
            Button(action: {
                signIn.signOut()
            }, label: {
                Text("Sign out")
            }).padding()
            
        }
    }
        
}

struct SignOut_Previews: PreviewProvider {
    static var previews: some View {
        SignOut()
    }
}
