//
//  FriendRequest.swift
//  CashApp
//
//  Created by Samuel Toh on 5/23/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth



struct FriendLandingPage: View {
    @ObservedObject var personalData = getPersonalData()
    
    var topFirstName: String
    var topLastName: String
    var topUsername: String
    var status: String
    var friend: Friend
    
    @State private var selectedTab = 1
    

    private var friendRequestButton: some View {
        HStack {
            if status == "accepted" {
                Button(action: {
                    
                }) {
                    CustomTextButton(text: "Friends")
                }
            } else if status == "pending" {
                Button(action: {
                    
                }) {
                    CustomTextButton(text: "Pending")
                }
            } else if status == "requested" {
                Button(action: {
                    
                }) {
                    CustomTextButton(text: "Requested")
                }
            } else {
                Button(action: {
                    let db = Firestore.firestore()
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    
                    let ref = db.collection("usernames").document(self.topUsername)
                    ref.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let friendID = document.get("UID") as! String
                            
                            db.collection("users").document(userID).collection("friends").document(friendID)
                                .setData(["email": "", "firstname": self.topFirstName, "lastname": self.topLastName, "status": "requested", "username": self.topUsername]) { (err) in
                                    if err != nil {
                                        print((err?.localizedDescription)!)
                                        return
                                    }
                            }
                            
                            db.collection("users").document(friendID).collection("friends").document(userID)
                                .setData(["email": self.personalData.email, "firstname": self.personalData.firstname, "lastname": self.personalData.lastname, "status": "pending", "username": self.personalData.username]) { (err) in
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
                    CustomTextButton(text: "Add Friend")
                }
            }
            
            Button(action: {
                
            }) {
                CustomTextButton(text: "8 Friends")
            }
        }
    }
    
    private var picker: some View {
        Picker(selection: $selectedTab, label: Text("")) {
            Text("Feed").tag(0)
            Text("Between  You").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                friend.image
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding(.top, 5)
                
                Text(topFirstName + " " + topLastName)
                Text(topUsername)
                
                Divider()
                
                friendRequestButton
                
                Button(action: {
                    
                }) {
                    Text("Pay or Request")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue).frame(width: 200, height: 50))
                        .foregroundColor(.white)
                }

                Divider()
                
                picker
                
                Divider()
                
                List {
                    if self.selectedTab == 0 {
                        Text("Feed")
                    } else {
                        Text("Between you")
                    }
                }
                
                

            }
            .navigationBarTitle(Text(topFirstName + " " + topLastName), displayMode: .inline)
        }
    }
}

struct FriendLandingPage_Previews: PreviewProvider {
    static var previews: some View {
        FriendLandingPage(topFirstName: "Yue Yin", topLastName: "Leong", topUsername: "@YueYin-Leong", status: "accepted", friend: friendData[0])
    }
}
