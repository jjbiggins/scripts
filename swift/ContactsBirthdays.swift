#!/usr/bin/env swift

import Contacts
import Foundation

let predicate = CNContact.predicateForContacts(matchingName: "Joe Biggins")
let keysToFetch = [CNContactGivenNameKey,
CNContactFamilyNameKey,CNContactPhoneNumbersKey,CNContactDatesKey,CNContactBirthdayKey] as [CNKeyDescriptor]

let store = CNContactStore()
do {
    let predicate = CNContact.predicateForContacts(matchingName: "Joe Biggins")
    let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)  
    let dateComponents:  DateComponents = contacts[0].birthday!
    let day = dateComponents.day!
    let month = dateComponents.month!
    print("\(month), \(day)")
} 
catch {
    print("Failed to fetch contact, error: \(error)")
    // Handle the error
}
