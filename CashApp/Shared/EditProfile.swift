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
    @State var firstname: String = ""
    @State var lastname: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State private var value : CGFloat = 0
    
    @ObservedObject var categories = getCategoriesData()

    
    var body: some View {
        VStack {
//            List(categories.datas) {i in
//                Text(i.firstname)
//            }
            TextField("First Name", text: $firstname)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)

            TextField("Last Name", text: $lastname)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)

            TextField("Username", text: $username)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)

            TextField("Email", text: $email)
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
                .setData(["firstname": self.firstname, "lastname": self.lastname, "username": self.username, "email": self.email]) { (err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    }
                }
                
                UIApplication.shared.endEditing(true)
            }) {
                Text("Save")
        })
        
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}

class getCategoriesData : ObservableObject {

    @Published var datas = [category]()

    init() {
        let db = Firestore.firestore()

        db.collection("categories").addSnapshotListener { (snap, err) in
            if err != nil {
                print ((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges {
                let id = i.document.documentID
                let firstname = i.document.get("firstname") as! String
                let lastname = i.document.get("lastname") as! String
                let username = i.document.get("username") as! String
                let email = i.document.get("email") as! String
            
                self.datas.append(category(id: id, firstname: firstname, lastname: lastname, username: username, email: email))
            
            }
        }
    }
}

struct category: Identifiable {
    var id: String
    var firstname: String
    var lastname: String
    var username: String
    var email: String
}
