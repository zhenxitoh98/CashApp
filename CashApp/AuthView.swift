//
//  AuthView.swift
//  CashApp
//
//  Created by Samuel Toh on 5/18/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Welcome Back!")
                .font(.system(size: 32, weight: .heavy))
            
            Text("Sign in to continue")
                .font(.system(size: 18, weight: .medium))
            
            VStack {
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(.all)
                    .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                    .cornerRadius(100.0)
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(.all)
                    .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                    .cornerRadius(100.0)
            }.padding(.vertical, 64)
            
            Button(action: signIn) {
                Text("Sign in")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue).frame(width: 150, height: 50))
                    .foregroundColor(.white)
                    .padding(10)
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            Spacer()
            
            NavigationLink(destination: SignUpView()) {
                HStack {
                    Text("I'm a new user.")
                        .font(.system(size: 14, weight: .light))
//                        .foregroundColor(.primary)
                    
                    Text("Create an account")
                        .font(.system(size: 14, weight: .semibold))
                }
            }
        }
        .padding(.horizontal, 32).resignKeyboardOnDragGesture()
        
    }
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    var body: some View {
        VStack {
            Text("Create Account")
                .font(.system(size: 32, weight: .heavy))
            
            Text("Sign up to get started")
                .font(.system(size: 18, weight: .medium))
            
            VStack {
                TextField("Email Address", text: $email)
                    .font(.system(size: 14))
                    .padding(.all)
                    .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                    .cornerRadius(100.0)
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(.all)
                    .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                    .cornerRadius(100.0)
            }.padding(.vertical, 64)
        
        
            Button(action: signUp) {
                Text("Create Account")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue).frame(width: 200, height: 50))
                    .foregroundColor(.white)
                    .padding(10)
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                .padding()
            }
            
            Spacer()
        }.padding(.horizontal, 32).resignKeyboardOnDragGesture()
        
    }
}

struct AuthView: View {
    var body: some View {
        NavigationView {
            SignInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
    }
}
