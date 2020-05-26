//
//  SendPayment.swift
//  CashApp
//
//  Created by Samuel Toh on 5/9/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import Introspect
import FirebaseFirestore
import FirebaseAuth





struct SendPayment: View {
    @State private var recipient = ""
    @State private var paymentAmount = ""
    @State private var paymentContent = ""
    @State private var isActive = true
    @State private var selectedTab = 0
    @State private var showingPaymentAlert = false
    
    var transactTypes = ["Pay", "Request"]
    
//    @ObservedObject var trans = getTransactionData()
    @ObservedObject var friendRequest = getFriendRequestData()
        
    var body: some View {
       
        NavigationView {

            List {
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
                
                ForEach(friendRequest.datas) { i in
                    if i.status == "" {
                        Section(header: Text("Top People")) {
                            Button(action : {
                                self.recipient = i.firstname + " " + i.lastname
                            }) {
                                FriendRow(friend: friendData[0], friendFirstName: i.firstname, friendLastName: i.lastname, friendUsername: i.username, status: i.status)
                            }
                        }
                    } else if i.status == "accepted" {
                        Section(header: Text("Friends")) {
                            Button(action : {
                                self.recipient = i.firstname + " " + i.lastname
                            }) {
                                FriendRow(friend: friendData[0], friendFirstName: i.firstname, friendLastName: i.lastname, friendUsername: i.username, status: i.status)
                            }
                        }
                    }
                }
            }
//            .alert(isPresented: $showingPaymentAlert) {
//                Alert(title: Text("Transaction confirmed"), message: Text("You sent $\(trans.amount) to \(trans.recipient)"), dismissButton: .default(Text("Done")))

//            }
            .navigationBarTitle("Pay or Request")
            .navigationBarItems(
                leading: picker,
                trailing:
                Button (action: {
//                    let db = Firestore.firestore()
//                    guard let userID = Auth.auth().currentUser?.uid else { return }
//
//                    db.collection("transaction")
//                    .document(userID)
//                    .collection("transaction1")
//                    .document()
//                        .setData(["amount": self.paymentAmount, "content": self.paymentContent, "recipient": self.recipient, "transaction_type": self.transactTypes[self.selectedTab]]) { (err) in
//                            if err != nil {
//                                print((err?.localizedDescription)!)
//                                return
//                            }
//                    }
//                    self.showingPaymentAlert.toggle()
//                    self.paymentAmount = ""
//                    self.recipient = ""
//                    self.paymentContent = ""

                    UIApplication.shared.endEditing(true)
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



