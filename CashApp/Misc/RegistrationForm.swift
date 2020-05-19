//
//  RegistrationForm.swift
//  HelloWorld
//
//  Created by Samuel Toh on 5/5/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct HapticFeedback {
    public static func generate(){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
}


struct RegistrationForm: View {
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword = ""
    
    var body: some View {
        

        VStack(alignment: .leading, spacing: 20) {
            Group {
                HStack {
                    Button(action: {
                        HapticFeedback.generate()
                    }) {
                        Text("Cancel")
                    }
                    Spacer()
                    Text("Sign Up")
                    
                    Spacer()
                    if self.isUserInformationValid() {
                        Button("Next") {
    
                        }
                        .disabled(false)
                    } else {
                        Button("Next") {
    
                        }
                        .disabled(true)
                    }
                }
                .padding(.top, 40)
                
                Divider()
            }

            Group {
                Text("First Name")
                    .font(.headline)
                TextField("John", text: $firstname)
                    .padding(.all)
                    .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                    .cornerRadius(100.0)
                
                Text("Last Name")
                    .font(.headline)
                TextField("Appleseed", text: $lastname)
                    .padding(.all)
                    .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                    .cornerRadius(100.0)
                
                Text("Email")
                    .font(.headline)
                TextField("john_appleseed@apple.com", text: $email)
                    .padding(.all)
                    .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                    .cornerRadius(100.0)
            
                Text("Password")
                    .font(.headline)
                SecureField("********", text: $password)
                    .padding(.all)
                    .background(Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0))
                    .cornerRadius(100.0)
            }

            Text("By tapping next, you agree to the Consent to Receive Elecronic Disclosures and understand that we'll send account notices to the email address provided.")
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.gray)
                .font(.system(size: 12))

            Text("Helpful Information")
                .foregroundColor(.gray)
                .font(.system(size: 12))

        }
        .padding(.horizontal, 15)
        .padding(.bottom, 250)

    }
    
    
    private func isUserInformationValid() -> Bool {
        if firstname.isEmpty {
            return false
        }

        if lastname.isEmpty {
            return false
        }

        if email.isEmpty {
            return false
        }

        if password.isEmpty {
            return false
        }

        return true
    }
    
    
    
    
    
}

struct RegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationForm()
    }
}
