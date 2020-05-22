//
//  EditProfile.swift
//  CashApp
//
//  Created by Samuel Toh on 5/20/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct EditProfile: View {
    @ObservedObject var categories = getCategoriesData()
    @State private var value : CGFloat = 0
    @State private var disabledButton: Bool = true
    
    var body: some View {
        let binding = Binding<String>(get: {
            self.categories.firstname
        }, set: {
            self.categories.firstname = $0
            self.disabledButton = false
        })
        
        
        return VStack {
            TextField("First Name", text: binding)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)

            TextField("Last Name", text: $categories.lastname)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)

            TextField("Username", text: $categories.username)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)

            TextField("Email", text: $categories.email)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)
        }
        .padding()
        .onTapGesture {
            UIApplication.shared.endEditing(true)
        }
        .offset(y: -self.value)
        .animation(.spring())
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti ) in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.value = height - 150
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti ) in

                self.value = 0
            }
        }
        .navigationBarTitle("Edit Profile")
        .navigationBarItems(trailing:
            Button(action: {
                let db = Firestore.firestore()
                guard let userID = Auth.auth().currentUser?.uid else { return }
                
                db.collection("profile")
                .document(userID)
                    .setData(["firstname": self.categories.firstname, "lastname": self.categories.lastname, "username": self.categories.username, "email": self.categories.email]) { (err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    }
                }
                
                UIApplication.shared.endEditing(true)
            }) {
                Text("Save")
            }.disabled(disabledButton)
        )
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}

class getCategoriesData : ObservableObject {

//    @Published var datas = [category]()
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var username = ""
    @Published var email = ""
    

    init() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let docRef = db.collection("profile").document(userID)

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
        
//        db.collection("profile").addSnapshotListener { (snap, err) in
//            if err != nil {
//                print ((err?.localizedDescription)!)
//                return
//            }
//
//            for i in snap!.documentChanges {
//                let id = i.document.documentID
//                let firstname = i.document.get("firstname") as! String
//                let lastname = i.document.get("lastname") as! String
//                let username = i.document.get("username") as! String
//                let email = i.document.get("email") as! String
//
//                self.datas.append(category(id: id, firstname: firstname, lastname: lastname, username: username, email: email))
//
//            }
//        }
    }
}

//struct category: Identifiable {
//    var id: String
//    var firstname: String
//    var lastname: String
//    var username: String
//    var email: String
//}
