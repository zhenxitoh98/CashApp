//
//  LandmarkRow.swift
//  HelloWorld
//
//  Created by Samuel Toh on 5/4/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
//    var landmark: Landmark
    var transaction: Transaction
    
    var body: some View {
        HStack {
            transaction.image
                .resizable()
                .frame(width: 50, height: 40)
                .clipShape(Circle())
                .padding(.bottom)
            
            VStack (alignment: .leading, spacing: 1) {
                HStack {
                    Text(transaction.person1 + " " + transaction.category.rawValue + " " + transaction.person2)
                        .font(.system(size: 12))
                    
                    Spacer()
                    
                    Text("+ $45.00")
                        .font(.system(size: 10))
                        .foregroundColor(Color(red: 65 / 255, green: 130 / 255, blue: 69 / 255))
                        .bold()
                }
                
                HStack {
                    Text("3h")
                        .fontWeight(.light)
                        .font(.system(size: 10))
                    
                    Image(systemName: "lock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                }
                
                Text(transaction.content)
                    .font(.system(size: 12))
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                HStack {
                    Image(systemName: "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                    Image(systemName: "message")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
            }
        }
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionRow(transaction: transactionData[0])
                .previewLayout(.fixed(width: 300, height: 70))
//            TransactionRow(landmark: landmarkData[0])
//                .previewLayout(.fixed(width: 300, height: 70))
//            TransactionRow(landmark: landmarkData[1])
//                .previewLayout(.fixed(width: 300, height: 70))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
