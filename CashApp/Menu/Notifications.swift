//
//  Notifications.swift
//  CashApp
//
//  Created by Samuel Toh on 5/12/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct test: View {
    var i: friendRequestData
    var friend: Friend
    
    var body: some View {
        List {
            if i.status == "pending" {
                HStack {
                    friend.image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.top, 5)
                        
                    VStack (alignment: .leading, spacing: 20) {
                        Text(self.i.firstname + " " + self.i.lastname + " wants to be friends")
                        
                        HStack (spacing: 50) {
                            Button(action: {
                                let db = Firestore.firestore()
                                guard let userID = Auth.auth().currentUser?.uid else { return }

                                let ref = db.collection("usernames").document(self.i.username)
                                ref.getDocument { (document, error) in
                                    if let document = document, document.exists {
                                        let friendUID =  document.get("UID") as! String

                                        db.collection("users").document(friendUID).collection("friends").document(userID)
                                            .updateData(["status": "accepted"]) { (err) in
                                                if err != nil {
                                                    print((err?.localizedDescription)!)
                                                    return
                                                }
                                        }

                                        db.collection("users").document(userID).collection("friends").document(friendUID)
                                            .updateData(["status": "accepted"]) { (err) in
                                                if err != nil {
                                                    print((err?.localizedDescription)!)
                                                    return
                                                }
                                        }
                                    } else {
                                        print("Document does not exist")
                                    }
                                }
                            }) {
                                Text("Accept")
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue).frame(width: 100, height: 35))
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: {
                                
                            }) {
                                Text("Remove")
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 100, height: 35)
                                    )
                            }
                        }.padding(.leading, 10)
                    }.padding(.leading, 20)
                }.padding(.bottom, 10).padding(.top, 10)
            }
        }
    }
}

struct Notifications: View {
    @ObservedObject var friendRequest = getFriendRequestData()

    var body: some View {
        VStack {
            checkPending
        }
        .navigationBarTitle("Notification", displayMode: .inline)
    }
    
    private var checkPending: some View {
        ForEach(friendRequest.datas) { i in
            test(i : i, friend: friendData[0])
        }
    }
}



struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
