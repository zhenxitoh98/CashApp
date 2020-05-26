//
//  PersonalDetail.swift
//  CashApp
//
//  Created by Samuel Toh on 5/24/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class getPersonalData : ObservableObject {

    @Published var firstname = ""
    @Published var lastname = ""
    @Published var username = ""
    @Published var email = ""
    

    init() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let docRef = db.collection("users").document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.firstname = document.get("firstname") as! String
                self.lastname = document.get("lastname") as! String
                self.username = document.get("username") as! String
                self.email = document.get("email") as! String
            } else {
                print("Document does not exist")
            }
        }
    }
}
