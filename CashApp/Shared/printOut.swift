//
//  printOut.swift
//  CashApp
//
//  Created by Samuel Toh on 6/8/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct printOut: View {
    @EnvironmentObject var userData: UserData
    
    var transaction: Transaction
    
    var body: some View {
        VStack {
            CircleImage(image: transaction.image)

            VStack {
                Text("Samuel Toh").bold()
                Text("@zhenxitoh98")
            }.padding(.top, 20)
            
            QrCodeGenerator(firstname: "Samuel", lastname: "Toh", username: "@zhenxitoh98", status:"")
                .padding(.top, 40).padding(.bottom, 20)
            
            
            Text("Scan QR Code for payment")
            
        }
    }
}
