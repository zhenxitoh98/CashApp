//
//  TransactionDetail.swift
//  HelloWorld
//
//  Created by Samuel Toh on 5/7/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import CodeScanner


struct Profile: View {
    @State private var selectedTab = 1
    @EnvironmentObject var userData: UserData
    @State private var isShowingScanner = false
    
    var transaction: Transaction
    
    var body: some View {
        
        NavigationView {
            VStack {

                Section {
                    picker
                }
                if selectedTab == 0 {
                    qrScanner
                } else if selectedTab == 1 {
                    MyCode
                }
            }
            .navigationBarTitle(Text("Profile"))
        }
    }
    
    private var qrScanner: some View {
        CodeScannerView(codeTypes: [.qr], simulatedData: "test", completion: self.handleScan)
        
//        Text("Scan")
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       self.isShowingScanner = false
       // more code to come
        
        switch result {
        case .success(_):
            print("Scanning succeeded")
        case .failure(_):
            print("Scanning failed")
        }
    }
    
    private var picker: some View {
        Picker(selection: $selectedTab, label: Text("")) {
            Text("Scan").tag(0)
            Text("My Code").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private var MyCode: some View {
        VStack {
        //            MapView(coordinate: transaction.locationCoordinate)
        //                .edgesIgnoringSafeArea(.top)
        //                .frame(height: 300)
                    
            CircleImage(image: transaction.image)
//                .offset(x: 0, y: -130)
//                .padding(.bottom, -130)
            
            Text("Samuel Toh")
            Text("@zhenxitoh98")
            
            Text("Scan QR Code for payment")
            
            HStack {
                Image(systemName: "printer")
                Image(systemName: "envelope")
                Image(systemName: "square.and.arrow.up")
            }

            Spacer()
        }
    }
    
    
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(transaction: transactionData[1])
    }
}
