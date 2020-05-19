//
//  Settings.swift
//  CashApp
//
//  Created by Samuel Toh on 5/12/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct Settings: View {
//    @State private var selectedSheet: Sheet.SheetType?
    
    var body: some View {
            List {
                Section(header: Text("PREFERENCES").padding(.top, 25)) {
                    Text("Edit Profile")
                    Text("Payment Methods")
                    Text("Privacy")
                    Text("Notifications")
                    Text("Friends & Social")
                    Text("Change Phone Number")
                }
                    
                Section(header: Text("BUYING").padding(.top, 10)) {
                    Text("Connect Browsers")
                    Text("Backup Payment")
                    Text("Connected Merchants")
                }
                
                Section(header: Text("SECURITY").padding(.top, 10)) {
                    Text("Face ID & PIN")
                    Text("Change Password")
                    Text("Remembered Devices")
                    Text("Identity Verification")
                }
                
                Section(header: Text("INFORMATION").padding(.top, 10)) {
                    Text("Legal")
                    Text("Helpful Information")
                }
                
                Section() {

                    Button(action: {
                        if let url = URL(string: "https://www.google.com/") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        makeRow(text: "Send Feedback")
                    }

                    Text("Rate CoinApp")
                }
                
                
            }.listStyle(GroupedListStyle())

                .navigationBarTitle("Settings", displayMode: .inline)
    }
    
    
    private func makeRow(text: String) -> some View {
        HStack {
            Text(LocalizedStringKey(text))
                .font(.body)
            Spacer()
            Image(systemName: "chevron.right").imageScale(.medium)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
