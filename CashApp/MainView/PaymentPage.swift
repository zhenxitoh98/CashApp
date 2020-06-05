//
//  PaymentPage.swift
//  CashApp
//
//  Created by Samuel Toh on 5/11/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import Expression

struct PaymentPage: View {
    @State var input = ""
    @State private var isActive = false
    @State private var paymentType = ""
    
    let data = [
            [
                KeyboardItem.one,
                KeyboardItem.two,
                KeyboardItem.three
            ],
            [
                KeyboardItem.four,
                KeyboardItem.five,
                KeyboardItem.six
            ],
            [
                KeyboardItem.seven,
                KeyboardItem.eight,
                KeyboardItem.nine
            ],
            [
                KeyboardItem.dot,
                KeyboardItem.zero,
                KeyboardItem.del
            ]
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("$" + input)
                    .font(.system(size: 80))
                    .padding(.all)
                
                VStack {
                    ForEach(data, id: \.self) { items in
                        HStack {
                            ForEach(items, id: \.self) { item in
                                Button (
                                    action: {
                                        if self.input.contains(".") && item == KeyboardItem.dot {
                                           print("exists")
                                        } else {
                                            self.input = item.operateAction(input: self.$input.wrappedValue)
                                        }
                                    }) {
                                        Text(item.rawValue).bold().frame(width: 130, height: 85).font(.system(size: 30))
                                    }
                            }
                        }
                    }
                }.padding(.top, 80)
            
                HStack {
                    Button(action: {
                        self.isActive.toggle()
                        self.paymentType = "Request"
                    }) {
                        Text("Request")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue).frame(width: 150, height: 50))
                            .foregroundColor(.white)
                            .padding(10)
                    }
                    
                    Spacer()
                        .frame(width: 100)
                    
                    Button(action: {
                        self.isActive.toggle()
                        self.paymentType = "Pay"
                        
                    }) {
                        Text("Pay")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue).frame(width: 150, height: 50))
                        .foregroundColor(.white)
                        .padding(10)
                    }
                }.padding(.top, 20).padding(.bottom, 40)
            }
            .navigationBarItems(leading:
                Button(action: {
                    
                }) {
                    Image(systemName: "viewfinder")
                        .imageScale(.large)
                }
            )
        }.sheet(isPresented: $isActive) {
            SendPayment_V2(paymentType: self.paymentType, paymentAmount: self.input)
        }
    }
}

struct PaymentPage_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPage()
    }
}
