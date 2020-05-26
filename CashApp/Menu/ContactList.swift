//
//  ContactList.swift
//  CashApp
//
//  Created by Samuel Toh on 5/25/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import Contacts
import SwiftUI
import os

class ContactStore: ObservableObject {
    @Published var contacts: [CNContact] = []
    @Published var error: Error? = nil

    func fetch() {
        os_log("Fetching contacts")
        do {
            let store = CNContactStore()
            let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,
                               CNContactPhoneNumbersKey as CNKeyDescriptor,
                               CNContactFamilyNameKey as CNKeyDescriptor]
//                               CNContactImageDataAvailableKey as CNKeyDescriptor,
//                               CNContactImageDataKey as CNKeyDescriptor]
            os_log("Fetching contacts: now")
            let containerId = store.defaultContainerIdentifier()
            let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            os_log("Fetching contacts: succesfull with count = %d", contacts.count)
            self.contacts = contacts
        } catch {
            os_log("Fetching contacts: failed with %@", error.localizedDescription)
            self.error = error
        }
    }
}

extension CNContact: Identifiable {
    var name: String {
        return [givenName, familyName].joined(separator: " ")
    }
    
    var phone: String {
        return phoneNumbers.first?.value.stringValue ?? ""
    }
}

struct ContactsView: View {
    @EnvironmentObject var store: ContactStore

    var body: some View {
        VStack{
//            Text("Contacts")
            if store.error == nil {
                List(store.contacts) { (contact: CNContact) in
                    return Text(contact.phone + contact.name)
                }.onAppear{
                    DispatchQueue.main.async {
                        self.store.fetch()
                    }
                }
            } else {
                Text("error: \(store.error!.localizedDescription)")
            }
        }
    }
}

struct ContactsViewOrError: View {
    var body: some View {
        ContactsView().environmentObject(ContactStore())
    }
}
