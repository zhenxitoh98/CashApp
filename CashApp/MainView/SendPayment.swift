//
//  SendPayment.swift
//  CashApp
//
//  Created by Samuel Toh on 5/9/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import Introspect






struct SendPayment: View {
    @State private var recipient = ""
    @State private var paymentAmount = ""
    @State private var paymentContent = ""
    @State private var isActive = true
//    @Binding var showSheetView: Bool
    @State private var selectedTab = 0
    var transactTypes = ["Pay", "Request"]
    
    var body: some View {
       
        NavigationView {

            List {
    //                    ForEach(userData.transactions) { transactions in
                // Crash happens here when foreach is used
    //                NavigationLink(destination: TransactionDetail(transaction: transactionData[0])) {
    //                    TransactionRow(transaction: transactionData[0])
    //                }
//                picker
                
                HStack {
                    Text("\(transactTypes[selectedTab]) $").bold()
                    TextField("0", text: $paymentAmount).keyboardType(.decimalPad)
                }

                HStack {
                    Text("To").bold()
                    TextField("Name, @username, phone, or email", text: $recipient)
                }

                HStack {
                    Text("For").bold()
                    TextField("Add a note", text: $paymentContent)
                }

//                QrCode()


                Section(header: Text("Top People")) {
                    Button(action : {
                        self.recipient = friendData[0].name
                    }) {
                        FriendRow(friend: friendData[0])
                    }
                    
                    Button(action : {
                        self.recipient = friendData[1].name
                    }) {
                        FriendRow(friend: friendData[1])
                    }
                    
                    Button(action : {
                        self.recipient = friendData[2].name
                    }) {
                        FriendRow(friend: friendData[2])
                    }
                    
                    Button(action : {
                        self.recipient = friendData[3].name
                    }) {
                        FriendRow(friend: friendData[3])
                    }
                }
                
                Section(header: Text("Friends")) {
                    Button(action : {
                        self.recipient = friendData[0].name
                    }) {
                        FriendRow(friend: friendData[0])
                    }
                    
                    Button(action : {
                        self.recipient = friendData[1].name
                    }) {
                        FriendRow(friend: friendData[1])
                    }
                    
                    Button(action : {
                        self.recipient = friendData[2].name
                    }) {
                        FriendRow(friend: friendData[2])
                    }
                    
                    Button(action : {
                        self.recipient = friendData[3].name
                    }) {
                        FriendRow(friend: friendData[3])
                    }
                }
            }
            .navigationBarTitle("Pay or Request")
            .navigationBarItems(
                leading:
//                HStack {
//                    Button (action: {
////                        self.showSheetView = false
//                        UIApplication.shared.endEditing()
//                    }) {
//                        Text("Cancel").bold()
//                    }
                picker
                ,
                trailing:
                Button (action: {
                    
                }) {
                    Text("Send").bold()
                }
            )
        }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
    }
    
    private var picker: some View {
        Picker(selection: $selectedTab, label: Text("")) {
            ForEach(0..<transactTypes.count) { index in
                Text(self.transactTypes[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        var didBecomeFirstResponder = false

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

    }

    @Binding var text: String
    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
