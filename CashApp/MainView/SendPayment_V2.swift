//
//  SendPayment.swift
//  CashApp
//
//  Created by Samuel Toh on 5/9/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import Introspect
import FirebaseFirestore
import FirebaseAuth





struct SendPayment_V2: View {
    @State private var recipient = ""
    @State private var paymentContent = ""
    @State private var showingPaymentAlert = false
    
    @State var paymentType: String
    @State var paymentAmount: String
    
    @ObservedObject var friendRequest = getFriendRequestData()
    @ObservedObject var allUsers = getAllUsersData()
        
    var body: some View {
       
        NavigationView {

            List {
                HStack {
                    Text("To").bold()
                    TextField("Name, @username, phone, or email", text: $recipient)
                }

                HStack {
                    Text("For").bold()
                    TextField("Add a note", text: $paymentContent)
                }
                
                Section(header: Text("Top People")) {
                    ForEach(friendRequest.datas.filter{($0.lastname.contains(recipient) || $0.firstname.contains(recipient) || $0.username.contains(recipient) || recipient == "") && ($0.status == "requested")}, id:\.self.id) { i in
                            Button(action : {
                                self.recipient = i.firstname + " " + i.lastname
                            }) {
                                FriendRow(friend: friendData[0], friendFirstName: i.firstname, friendLastName: i.lastname, friendUsername: i.username, status: i.status)
                            }
                        }
                    }
                
                Section(header: Text("Friends")) {
                    ForEach(friendRequest.datas.filter{($0.lastname.contains(recipient) || $0.firstname.contains(recipient) || $0.username.contains(recipient) || recipient == "") && ($0.status == "accepted")}, id:\.self.id) { i in
                            Button(action : {
                                self.recipient = i.firstname + " " + i.lastname
                            }) {
                                FriendRow(friend: friendData[0], friendFirstName: i.firstname, friendLastName: i.lastname, friendUsername: i.username, status: i.status)
                            }
                        }
                    }
                
                Section(header: Text("Other people on Coin App")) {
                    ForEach(allUsers.datas.filter{$0.lastname.contains(recipient) || $0.firstname.contains(recipient) || $0.username.contains(recipient) || recipient == ""}, id:\.self.id) { i in
                            Button(action : {
                                self.recipient = i.firstname + " " + i.lastname
                            }) {
                                FriendRow(friend: friendData[0], friendFirstName: i.firstname, friendLastName: i.lastname, friendUsername: i.username, status: "Add Friend")
                            }
                        }
                    }
            }
//            .alert(isPresented: $showingPaymentAlert) {
//                Alert(title: Text("Transaction confirmed"), message: Text("You sent $\(trans.amount) to \(trans.recipient)"), dismissButton: .default(Text("Done")))

//            }
                .navigationBarTitle("$\(paymentAmount)", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button (action: {
//                    let db = Firestore.firestore()
//                    guard let userID = Auth.auth().currentUser?.uid else { return }
//
//                    db.collection("transaction")
//                    .document(userID)
//                    .collection("transaction1")
//                    .document()
//                        .setData(["amount": self.paymentAmount, "content": self.paymentContent, "recipient": self.recipient, "transaction_type": self.transactTypes[self.selectedTab]]) { (err) in
//                            if err != nil {
//                                print((err?.localizedDescription)!)
//                                return
//                            }
//                    }
//                    self.showingPaymentAlert.toggle()
//                    self.paymentAmount = ""
//                    self.recipient = ""
//                    self.paymentContent = ""

                    UIApplication.shared.endEditing(true)
                }) {
                    Text(self.paymentType).bold()
                }
            )
        }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
    }
}



