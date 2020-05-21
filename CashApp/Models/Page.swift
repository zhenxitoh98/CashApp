//
//  Page.swift
//  CashApp
//
//  Created by Samuel Toh on 5/19/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import Foundation

struct Page: Identifiable {
    
    let id: UUID
    let image: String
    let heading: String
    let subSubheading: String
    
    static var getAll: [Page] {
        [
            Page(id: UUID(), image: "screen-1", heading: "Form new habits", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
            Page(id: UUID(), image: "screen-2", heading: "Keep track of your progress", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
            Page(id: UUID(), image: "screen-3", heading: "Setup your goals", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
            Page(id: UUID(), image: "screen-4", heading: "Keep track of your progress", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.")
            
        ]
    }
}
