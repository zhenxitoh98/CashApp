//
//  Purchases.swift
//  CashApp
//
//  Created by Samuel Toh on 5/12/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct Purchases: View {
    @State private var phoneNumber: String = ""

    
    var body: some View {
        

            List {
                Section(header: Text("Completed Purchases")) {
                    Text("Uber Eats")
                }
            }.listStyle(GroupedListStyle())

        .navigationBarTitle("Purchases")
//        VStack {
//            Text("Purchases")
//
//            TextField("124567890", text: $phoneNumber).keyboardType(.phonePad).padding().background(Color("Color")).clipShape(RoundedRectangle(cornerRadius: 10)).padding(.top, 1)
//        }
    }
}

struct Purchases_Previews: PreviewProvider {
    static var previews: some View {
        Purchases()
    }
}
