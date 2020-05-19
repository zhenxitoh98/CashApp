//
//  AboutView.swift
//  CashApp
//
//  Created by Samuel Toh on 5/15/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    
    var body: some View {
        List {
            Section(header: Text("The App").padding(.top, 25)) {
                Text("Report an inssue")
                Text("Rate the app")
                Text("Privacy Policy")
                Text("Terms of Use")
                Text("App version")
            }
                

            

        }.listStyle(GroupedListStyle())

            .navigationBarTitle("About", displayMode: .inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
