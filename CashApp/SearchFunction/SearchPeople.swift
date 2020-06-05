//
//  SearchPeople.swift
//  CashApp
//
//  Created by Samuel Toh on 5/11/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import Introspect
import FirebaseFirestore
import FirebaseAuth

struct SearchPeople: View {
    let array = ["Peter", "Paul", "Mary", "Anna-Lena", "George", "John", "Greg", "Thomas", "Robert", "Bernie", "Mike", "Benno", "Hugo", "Miles", "Michael", "Mikel", "Tim", "Tom", "Lottie", "Lorrie", "Barbara"]
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    @ObservedObject var friendRequest = getFriendRequestData()
    @ObservedObject var allUsers = getAllUsersData()


    var body: some View {

        NavigationView {
            VStack (alignment: .leading) {
                searchField
        
                List {
                    
                    QrCode()
                    
                    Section(header: Text("Top People")) {
                        ForEach(friendRequest.datas.filter{($0.lastname.contains(searchText) || $0.firstname.contains(searchText) || $0.username.contains(searchText) || searchText == "") && ($0.status == "requested")}, id:\.self.id) { i in
                                Button(action : {

                                }) {
                                    FriendRow(friend: friendData[0], friendFirstName: i.firstname, friendLastName: i.lastname, friendUsername: i.username, status: i.status)
                                }
                            }
                        }
                    
                    Section(header: Text("Friends")) {
                        ForEach(friendRequest.datas.filter{($0.lastname.contains(searchText) || $0.firstname.contains(searchText) || $0.username.contains(searchText) || searchText == "") && ($0.status == "accepted")}, id:\.self.id) { i in
                                Button(action : {

                                }) {
                                    FriendRow(friend: friendData[0], friendFirstName: i.firstname, friendLastName: i.lastname, friendUsername: i.username, status: i.status)
                                }
                            }
                        }
                    
                    Section(header: Text("Other people on Coin App")) {
                        ForEach(allUsers.datas.filter{$0.lastname.contains(searchText) || $0.firstname.contains(searchText) || $0.username.contains(searchText) || searchText == ""}, id:\.self.id) { i in
                                Button(action : {

                                }) {
                                    FriendRow(friend: friendData[0], friendFirstName: i.firstname, friendLastName: i.lastname, friendUsername: i.username, status: "Add Friend")
                                }
                            }
                        }
                }
            }
            .navigationBarTitle(Text("Search People"))
            .navigationBarItems(trailing: invite)
            .resignKeyboardOnDragGesture()
        }
    }
    
    private var invite: some View {
        Button(action: {
            
        }) {
            Text("Invite")
        }
    }
    
    private var searchField: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("Name or @username", text: $searchText, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                }).foregroundColor(.primary)

                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)

            if showCancelButton  {
                Button("Cancel") {
                        UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                        self.searchText = ""
                        self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)//.animation(.default)
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

struct SearchPeople_Previews: PreviewProvider {
    static var previews: some View {
        SearchPeople()
    }
}
