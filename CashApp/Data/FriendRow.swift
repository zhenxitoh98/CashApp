//
//  friendsRow.swift
//  CashApp
//
//  Created by Samuel Toh on 5/9/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct FriendRow: View {
    @State var showSheetView = false
    @State private var showLinkTarget = false
    
    var friend: Friend
    var friendFirstName: String
    var friendLastName: String
    var friendUsername: String
    var status: String

    
    var body: some View {
        HStack {
            friend.image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.top, 5)

            
            VStack (alignment: .leading, spacing: 1) {
                Text(friendFirstName + " " + friendLastName)
                Text(friendUsername)
                    .font(.system(size: 10))
                    .foregroundColor(Color(red: 89 / 255, green: 89 / 255, blue: 89 / 255))
            }
            
            Spacer()
            
            Button (action: {
                self.showLinkTarget = true
            }) {
                Image (systemName: "info.circle")
                    .imageScale(.large)
            }.sheet(isPresented: $showLinkTarget) {
                FriendLandingPage(topFirstName: self.friendFirstName, topLastName: self.friendLastName, topUsername: self.friendUsername, status: self.status, friend: friendData[0])
            }
        }
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FriendRow(friend: friendData[0], friendFirstName: "", friendLastName: "", friendUsername: "", status: "")
                .previewLayout(.fixed(width: 300, height: 70))
        }.previewLayout(.fixed(width: 300, height: 70))

    }
}
