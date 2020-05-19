//
//  QrCode.swift
//  CashApp
//
//  Created by Samuel Toh on 5/16/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import CodeScanner

struct QrCode: View {
    @State private var isShowingScanner = false
    
    
    var body: some View {
        
        
        HStack {
            Group {
                Image(systemName: "qrcode")
                    .imageScale(.large)
                    .background(Circle()
                        .stroke(Color.blue, lineWidth: 2)
                        .frame(width: 40, height: 40)
                )
            }
            .padding(.trailing, 15)
            .padding(.leading, 15)
                                    

            VStack (alignment: .leading) {

                Text("Scan Code")
                Text("Quickly pay or request money.")
            }
        }.onTapGesture {
            self.isShowingScanner = true
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "test", completion: self.handleScan)
            
            Text("Scan")
            
            .navigationBarTitle("Scan", displayMode: .inline)
        }
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
}




struct QrCode_Previews: PreviewProvider {
    static var previews: some View {
        QrCode()
    }
}
