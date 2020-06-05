//
//  KeyboardItem.swift
//  CashApp
//
//  Created by Samuel Toh on 6/4/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import Foundation

enum KeyboardItem: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case dot = "."
    case del = "DEL"
    
    func operateAction(input: String) -> String {
        switch self {
        case .zero : return input + "0"
        case .one : return input + "1"
        case .two : return input + "2"
        case .three : return input + "3"
        case .four : return input + "4"
        case .five : return input + "5"
        case .six : return input + "6"
        case .seven : return input + "7"
        case .eight : return input + "8"
        case .nine : return input + "9"
        case .dot : return input + "."
        case .del : return String(input.dropLast())
        }
    }
}
