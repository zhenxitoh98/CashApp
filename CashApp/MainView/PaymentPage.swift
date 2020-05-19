//
//  PaymentPage.swift
//  CashApp
//
//  Created by Samuel Toh on 5/11/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct PaymentPage: View {
    @State private var recipient = ""
    @State private var location: Int = 0

    @State private var dot = false
    
    let digits = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [-1, 0, -2]]
    var body: some View {
        _ = Binding<Int>(get: {
            self.location
        }, set: {
            self.location = $0
            // do whatever you want here
        })
        
        return VStack (spacing: 8) {
        
            Text("$\(location)")
                .font(.largeTitle)
                .padding(.all)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .border(Color.blue)
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 60)

        
            
            ForEach(digits, id: \.self) {rowDigits in
                HStack(spacing: 8) {
                    ForEach(rowDigits, id: \.self) {digit in
                        Button("\(digit)", action: {
                            self.location = self.location * 10 + digit
                        })
                            .frame(width: 64, height: 64)
                            .border(Color.blue)
                    }
                }
            }
            
            HStack {
                Button(action: {
                    
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
                    
                }) {
                    Text("Pay")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue).frame(width: 150, height: 50))
                    .foregroundColor(.white)
                    .padding(10)
                }
            }
            .padding(.top, 40)
            .padding(.leading)
            .padding(.trailing)
            
            
            

        }
        
        
        
        
        .navigationBarTitle("Pay or Request")
    }
}

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

struct PaymentPage_Previews: PreviewProvider {
    static var previews: some View {
        PaymentPage()
    }
}
