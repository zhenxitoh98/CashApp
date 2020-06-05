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

class getAllUsersData: ObservableObject {
        @Published var datas = [allUsersData]()

    init() {
        let db = Firestore.firestore()
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").addSnapshotListener { (snap, err) in
            if err != nil {
                print ((err?.localizedDescription)!)
                return
            }

            for i in snap!.documentChanges {
                let ref = i.document.documentID
                let docRef = db.collection("users").document(userID).collection("friends").document(ref)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
//                        print("in friends")
                    } else if i.document.documentID == userID {
//                        print("myself")
                    } else {
                        if i.type == .added {
                            let id = i.document.documentID
                            let firstname = i.document.get("firstname") as! String
                            let lastname = i.document.get("lastname") as! String
                            let username = i.document.get("username") as! String
                            let email = i.document.get("email") as! String

                            self.datas.append(allUsersData(id: id, firstname: firstname, lastname: lastname, username: username, email: email))
                        }
                    }
                }
            }
        }
    }
}

struct allUsersData: Identifiable {
    var id: String
    var firstname: String
    var lastname: String
    var username: String
    var email: String
}
