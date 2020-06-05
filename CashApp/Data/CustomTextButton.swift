//
//  CustomTextField.swift
//  CashApp
//
//  Created by Samuel Toh on 5/25/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct CustomTextButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .font(.system(size: 15))
            .foregroundColor(.blue)
        .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 100, height: 35)
            )
    }
}

struct CustomTextButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextButton(text: "Testing")
    }
}
