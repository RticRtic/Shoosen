//
//  SignOut.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-28.
//

import SwiftUI


struct SignOut: View {
    @EnvironmentObject var signIn: SignIn
    var body: some View {
            Button(action: {
                signIn.signOut()
            }, label: {
                Text("Sign out")
            }).padding()
            
        
        
    }
}

struct SignOut_Previews: PreviewProvider {
    static var previews: some View {
        SignOut()
    }
}
