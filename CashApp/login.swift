//
//  login.swift
//  CashApp
//
//  Created by Samuel Toh on 5/18/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct login: View {
    
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                Text("Welcome back user!")
                Button(action: session.signOut) {
                    Text("Sign Out")
                }
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login().environmentObject(SessionStore())
    }
}
