//
//  QrCode.swift
//  CashApp
//
//  Created by Samuel Toh on 5/16/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import CodeScanner

private enum ActiveSheet {
   case first, second
}

struct QrCode: View {
    @State private var isShowingScanner = false
    @State private var isShowingProfile = false
    @State private var activeSheet: ActiveSheet = .first
    
    @State var firstname = ""
    @State var lastname = ""
    @State var username = ""
    @State var status = ""
    
    
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
            self.activeSheet = .first
        }
        .sheet(isPresented: $isShowingScanner) {
            if self.activeSheet == .first {
                NavigationView {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "test") { result in

                        switch result {
                            case .success(let code):
                                let details = code.components(separatedBy: "\n")
                                guard details.count == 5 else { return }

                                self.firstname = details[0]
                                self.lastname = details[1]
                                self.username = details[2]
                                self.status = details[3]

                                self.activeSheet = .second
                            case .failure(let error):
                                print(error.localizedDescription)
                        }
                    }
                    
//                    Text("Scan")
                
                    .navigationBarTitle("Scan", displayMode: .inline)
                    .navigationBarItems(leading:
                        Button(action: {
                            self.isShowingScanner = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                        }
                    )
                }
            } else {
                FriendLandingPage(topFirstName: self.firstname, topLastName: self.lastname, topUsername: self.username, status: self.status, friend: friendData[0])
            }
        }
    }
}




struct QrCode_Previews: PreviewProvider {
    static var previews: some View {
        QrCode()
    }
}
