//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Samuel Toh on 5/16/20.
//
//

import Foundation
import CoreData


extension Post: Identifiable {


    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var comments: String
    @NSManaged public var username: String
//    @NSManaged public var friends: String
//    @NSManaged public var likes: String
//    @NSManaged public var date: Date
//    @NSManaged public var amount: Int16
//    @NSManaged public var transactionType: String
//    @NSManaged public var privacyType: String
    @NSManaged public var id: UUID

//    var tType: TransactionType {
//        set {transactionType = newValue.rawValue}
//        get {TransactionType(rawValue: transactionType) ?? .paid}
//    }
//
//    var pType: PrivacyType {
//        set {privacyType = newValue.rawValue}
//        get {PrivacyType(rawValue: privacyType) ?? .publicOnly}
//
//    }
    
}

//enum PrivacyType: String {
//    case publicOnly = "Public"
//    case privateOnly = "Private"
//    case friendsOnly = "Friends"
//}

//enum TransactionType: String {
//    case paid = "Paid"
//    case charged = "Charged"
//}
