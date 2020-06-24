//
//  MenuView.swift
//  HelloWorld
//
//  Created by Samuel Toh on 5/6/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import Introspect

struct MenuView: View {
    @EnvironmentObject var session: SessionStore
    
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
//        UITableView.appearance().separatorStyle = .none
    }
    
    private var info: some View {
        VStack {
            Divider()
            
            HStack {
                Text("$0.00 in Coin App")
                    .font(.system(size: 18))
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("Transfer balance")
                        .font(.system(size: 18))
                }
            }
            
            Divider()
        }.padding(30)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                info
                
                List {
                    NavigationLink (destination: Notifications()) {
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                                .frame(width: 20, height: 20)
                            Text("Notifications")
                                .font(.headline)
                            Spacer()
                        }.padding(.top, 30)
                    }
                    
                    NavigationLink (destination: Incomplete()) {
                        HStack {
                            Image(systemName: "circle.righthalf.fill")
                                .foregroundColor(.gray)
                                .frame(width: 20, height: 20)
                            Text("Incompletes")
                                .font(.headline)
                            Spacer()
                        }.padding(.top, 30)
                    }
                    
                    NavigationLink (destination: Purchases()) {
                        HStack {
                            Image(systemName: "cart")
                                .foregroundColor(.gray)
                                .frame(width: 20, height: 20)
                            Text("Purchases")
                                .font(.headline)
                            Spacer()
                        }.padding(.top, 30)
                    }
                    
                    NavigationLink (destination: Settings()) {
                        HStack {
                            Image(systemName: "gear")
                                .foregroundColor(.gray)
                                .frame(width: 20, height: 20)
                            Text("Settings")
                                .font(.headline)
                            Spacer()
                        }.padding(.top, 30)
                    }
                    
                    NavigationLink (destination: GetHelp()) {
                        HStack {
                            Image(systemName: "questionmark")
                                .foregroundColor(.gray)
                                .frame(width: 20, height: 20)
                            Text("Get Help")
                                .font(.headline)
                            Spacer()
                        }.padding(.top, 30)
                    }
                    
                    NavigationLink (destination: AboutView()) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.gray)
                                .frame(width: 20, height: 20)
                            Text("About")
                                .font(.headline)
                            Spacer()
                        }.padding(.top, 30)
                    }
                    
                    
                    Button(action: session.signOut) {
                        HStack {
                            Image(systemName: "square.and.arrow.down")
                                .foregroundColor(.blue)
                                .frame(width: 20, height: 20)
                            Text("Sign Out")
                                .foregroundColor(.blue)
                                .font(.headline)
                        }.padding(.top, 30)
                    }
                }
            }
//            .padding()
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("More")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(SessionStore())
    }
}





