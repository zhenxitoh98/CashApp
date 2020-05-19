//
//  MotherView.swift
//  CashApp
//
//  Created by Samuel Toh on 5/11/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    
//    @State var page: String = "page2"
    //State properties are used for displaying views depending on the State's data
    //Every time the State gets updated it triggers that view rerender.
    
    //ObservableObjects can contain data, we can bind views to the ObservableObject, we can make these views observe the object, the observing views can access and manipulate the data inside the ObservableObject. When a change happens to the ObservableObject's data all observing views get automatically notified and rerendered similar to when a state changes
//    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        TabView {
            ContentView()
              .tabItem {
                 Image(systemName: "list.dash")
                 Text("Dashboard")
            }
            
            SendPayment()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Send")
            }
            
            SearchPeople()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
            
            Profile(transaction: transactionData[1])
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Personal")
            }
            
            MenuView()
                .tabItem {
                    Image(systemName: "ellipsis.circle.fill" )
                    Text("More")
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
    }
}
