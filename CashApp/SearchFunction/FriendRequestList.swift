//
//  FriendRequestList.swift
//  CashApp
//
//  Created by Samuel Toh on 5/24/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class getFriendRequestData: ObservableObject {
        @Published var datas = [friendRequestData]()

    init() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else { return }

        db.collection("users").document(userID).collection("friends").addSnapshotListener { (snap, err) in
            if err != nil {
                print ((err?.localizedDescription)!)
                return
            }

            for i in snap!.documentChanges {
                if i.type == .added {
                    let id = i.document.documentID
                    let firstname = i.document.get("firstname") as! String
                    let lastname = i.document.get("lastname") as! String
                    let username = i.document.get("username") as! String
                    let email = i.document.get("email") as! String
                    let status = i.document.get("status") as! String

                    self.datas.append(friendRequestData(id: id, firstname: firstname, lastname: lastname, username: username, email: email, status: status))
                }
                
                if i.type == .modified {
                    let id = i.document.documentID
                    let status = i.document.get("status") as! String
                    
                    for j in 0..<self.datas.count {
                        if self.datas[j].id == id {
                            self.datas[j].status = status
                        }
                    }
                }
            }
        }
    }
}

struct friendRequestData: Identifiable {
    var id: String
    var firstname: String
    var lastname: String
    var username: String
    var email: String
    var status: String
}
