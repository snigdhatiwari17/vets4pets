//
//  Constants.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 01/02/24.
//

import Foundation

let REALM_QUEUE = DispatchQueue(label: "realmQueue") //global variable
let REALM = "realRunConfig"

struct K {
 
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
  static let appName = "Vets4Pets🐶"
    
    static let moreDetailsSegue = "toMoreDetails"
    static let adminSegue = "toAdminHome"
}

