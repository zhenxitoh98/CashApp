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
    @ObservedObject var personalData = getPersonalData()
    @State private var value : CGFloat = 0
    @State private var disabledButton: Bool = true
    
    var body: some View {
        let binding = Binding<String>(get: {
            self.personalData.firstname
        }, set: {
            self.personalData.firstname = $0
            self.disabledButton = false
        })
        
        
        return VStack {
            TextField("First Name", text: binding)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)

            TextField("Last Name", text: $personalData.lastname)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)

            TextField("Username", text: $personalData.username)
                .font(.system(size: 14))
                .padding(.all)
                .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                .cornerRadius(100.0)

            TextField("Email", text: $personalData.email)
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
                
                db.collection("users")
                .document(userID)
                    .setData(["firstname": self.personalData.firstname, "lastname": self.personalData.lastname, "username": self.personalData.username, "email": self.personalData.email]) { (err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    }
                }
                
                db.collection("usernames")
                    .document(self.personalData.username)
                    .setData(["UID": userID]) { (err) in
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


