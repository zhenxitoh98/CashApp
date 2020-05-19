//
//  RegistrationForm.swift
//  HelloWorld
//
//  Created by Samuel Toh on 5/5/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct ProfilePage: View {
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var email = ""
//    @State private var password = ""
    @State private var location = ""
    @State private var termsAccepted = false
    @State private var age = 20
    
    private let oldPasswordToConfirmAgainst = "12345"
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmedPassword = ""

    
    var body: some View {
//        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    TextField("First Name", text: $firstname)
                    TextField("Last Name", text: $lastname)
                    TextField("Email", text: $email)
                    Picker(selection: $location,
                           label: Text("Location")) {
                            ForEach(Location.allLocations, id: \.self) { location in
                                Text(location).tag(location)
                            }
                    }
                    
                    Toggle(isOn: $termsAccepted,
                           label: {
                                Text("Accept terms and conditions")
                    })
                    
                    Stepper(value: $age,
                            in: 18...100,
                            label: {
                                Text("Current age: \(self.age)")
                    })
                    
                    if self.isUserInformationValid() {
                        Button(action: {
                            print("Updated profile")
                        }, label: {
                            Text("Update Profile")
                        })
                    }
                }
                Section(header: Text("Password")) {
                    SecureField("Enter Old Password", text: $oldPassword)
                    SecureField("New Password", text: $newPassword)
                    SecureField("Confirm New Password", text: $confirmedPassword)
                    
                    if self.isPasswordValid() {
                        Button(action: {
                            print("Updated password")
                        }, label: {
                            Text("Update password")
                        })
                    }

                }
            }.navigationBarTitle(Text("Profile"))
//        }
    }
    
    private func isUserInformationValid() -> Bool {
        if firstname.isEmpty {
            return false
        }
        
        if lastname.isEmpty {
            return false
        }
        
        if !termsAccepted {
            return false
        }
        
        if location.isEmpty {
            return false
        }
        
        return true
    }
    
    private func isPasswordValid() -> Bool {
        if oldPassword != oldPasswordToConfirmAgainst {
            return false
        }
        
        if !newPassword.isEmpty && newPassword == confirmedPassword {
            return true
        }
        
        return false
    }
}

struct Location {
    static let allLocations = [
        "Selangor",
        "Melaka",
        "Perak",
        "Negeri Sembilan",
        "Johor"
    ]
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
