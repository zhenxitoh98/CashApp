//
//  Incomplete.swift
//  CashApp
//
//  Created by Samuel Toh on 5/12/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct Incomplete: View {
//    var incompleteType = ["Requests", "Payments"]
    @State private var incompleteType = 0
    @State private var checkEmpty = true
    
    var body: some View {

        List {
            Section(header: picker) {
                if incompleteType == 0 && !checkEmpty {
                    Text("requests")
                } else if incompleteType == 1 && !checkEmpty {
                    Text("payments")
                } else {
                    emptyView
                }
            }
        }.listStyle(GroupedListStyle())
            .navigationBarTitle("Incomplete", displayMode: .inline)
    }
    
    private var picker: some View {
        Picker(selection: $incompleteType, label: Text("")) {
            Text("Requests").tag(0)
            Text("Payments").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private var emptyView: some View {
        if incompleteType == 0 {
            return Text("Requests From you")
        } else {
            return Text("Payment Invites")
        }
    }
}

struct Incomplete_Previews: PreviewProvider {
    static var previews: some View {
        Incomplete()
    }
}
