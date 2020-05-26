//
//  Settings.swift
//  CashApp
//
//  Created by Samuel Toh on 5/12/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct customText: View {
    var img: String
    var text: String

    
    var body: some View {
        HStack {
            Image(systemName: img).frame(width: 10, height: 10).foregroundColor(.gray)
            
            Text(text)
                .padding(.leading, 20)
        }
    }
}

struct Settings: View {
//    @State private var selectedSheet: Sheet.SheetType?
    
    var body: some View {
        List {
            Section(header: Text("PREFERENCES").padding(.top, 25)) {
                NavigationLink(destination: EditProfile()) {
                    customText(img: "person.fill", text: "Edit Profile")
                }
                
                NavigationLink(destination: EmptyView()) {
                    customText(img: "dollarsign.square.fill", text: "Payment Methods")
                }
                
                NavigationLink(destination: EmptyView()) {
                    customText(img: "lock.fill", text: "Privacy")
                }
                NavigationLink(destination: EmptyView()) {
                    customText(img: "bell.fill", text: "Notifications")
                }
                NavigationLink(destination: EmptyView()) {
                    customText(img: "person.2.fill", text: "Friends & Social")
                }
                NavigationLink(destination: EmptyView()) {
                    customText(img: "phone.circle.fill", text: "Change Phone Number")
                }
            }
                
            Section(header: Text("BUYING").padding(.top, 10)) {
                NavigationLink(destination: ContactsView()) {
                    customText(img: "globe", text: "Connect Browsers")
                }
                NavigationLink(destination: EmptyView()) {
                    customText(img: "creditcard.fill", text: "Backup Payment")
                }
                NavigationLink(destination: EmptyView()) {
                    customText(img: "doc.on.clipboard.fill", text: "Connected Merchants")
                }
            }
            
            Section(header: Text("SECURITY").padding(.top, 10)) {
                NavigationLink(destination: EmptyView()) {
                    customText(img: "faceid", text: "Face ID & Pin")
                }
                NavigationLink(destination: EmptyView()) {
                    customText(img: "lock.fill", text: "Change Password")
                }
                NavigationLink(destination: EmptyView()) {
                    customText(img: "desktopcomputer", text: "Remembered Devices")
                }
                NavigationLink(destination: EmptyView()) {
                    customText(img: "creditcard", text: "Identity Verification")
                }
            }
            
            Section(header: Text("INFORMATION").padding(.top, 10)) {
                NavigationLink(destination: EmptyView()) {
                    customText(img: "doc.on.clipboard.fill", text: "Legal")
                }
                NavigationLink(destination: EmptyView()) {
                    customText(img: "doc.on.clipboard.fill", text: "Helpful Information")
                }
            }
            
            Section() {

                Button(action: {
                    if let url = URL(string: "https://www.google.com/") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    makeRow(img: "paperplane", text: "Send Feedback")
                }

                Button(action: {
                    if let url = URL(string: "https://www.google.com/") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    makeRow(img: "star.fill", text: "Rate CoinApp")
                }
            }
            
            
        }.listStyle(GroupedListStyle())

        .navigationBarTitle("Settings", displayMode: .inline)
    }
    
    
    private func makeRow(img: String, text: String) -> some View {
        HStack {
            Image(systemName: img).frame(width: 10, height: 10)
            
            Text(text)
                .padding(.leading, 20)
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
