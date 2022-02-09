//
//  ContentView.swift
//  Shoosen
//
//  Created by Jesper Söderling on 2022-01-07.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var signIn: SignIn
        
    
    
    var body: some View {
        NavigationView {
            if signIn.signedIn {
                VStack {
                    TapBar()
                }
                
            } else {
                SignInView()
            }
        } .onAppear {
            signIn.signedIn = signIn.isSignedIn
        } 
        .navigationViewStyle(.stack)
       
    }
    
    
    
    
    
    struct SignInView: View {
        
        @State var email: String = ""
        @State var password: String = ""
        @EnvironmentObject var signIn: SignIn
        
        var body: some View {
            NavigationView {
                VStack {
                    //Logo
                    VStack {
                        TextField("Email Adress", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(.gray)
                            .cornerRadius(8)
                        
                        SecureField("Enter Password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(.gray)
                            .cornerRadius(8)
                        
                        Button(action: {
                            guard !email.isEmpty, !password.isEmpty else {return}
                            signIn.signIn(email: email, password: password)
                            
                        }, label: {
                            Text("Sign in")
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(.blue)
                                .cornerRadius(8)
                        })
                        
                        NavigationLink("Create Account", destination: SignUpView())
                            .padding()
                        
                        
                    }
                    .padding()
                    
                    Spacer()
                }
                //.navigationTitle("Sign In")
            }
            
        }
        
        
    }
}

struct SignUpView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var signIn: SignIn
    
    var body: some View {
        NavigationView {
            VStack {
                //Logo
                VStack {
                    TextField("Email Adress", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(.gray)
                        .cornerRadius(8)
                    
                    SecureField("Enter Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(.gray)
                        .cornerRadius(8)
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {return}
                        signIn.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(.blue)
                            .cornerRadius(8)
                    })
                    
                    
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Create Account")
        }
        
    }
    
    
}







