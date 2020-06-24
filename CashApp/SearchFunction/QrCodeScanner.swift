//
//  QrCodeScanner.swift
//  CashApp
//
//  Created by Samuel Toh on 6/5/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import CodeScanner

struct QrCodeScanner: View {
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var username = ""
    @State private var status = ""
    
    var body: some View {
        CodeScannerView(codeTypes: [.qr], simulatedData: "test") { result in

            switch result {
                case .success(let code):
                    let details = code.components(separatedBy: "\n")
                    guard details.count == 4 else { return }
                    
                    print(details)

                    self.firstname = details[0]
                    self.lastname = details[1]
                    self.username = details[2]
                    self.status = details[3]

                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

struct QrCodeScanner_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeScanner()
    }
}
