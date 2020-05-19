//
//  UserData.swift
//  HelloWorld
//
//  Created by Samuel Toh on 5/5/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var transactions = transactionData
    @Published var friends = friendData
    //include an instance of the user profile that persists even after the user dismisses the profile view
}

