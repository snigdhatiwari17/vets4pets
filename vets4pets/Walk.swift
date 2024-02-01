//
//  Walk.swift
//  IA
//
//  Created by Snigdha Tiwari  on 26/07/23.
//

import Foundation
import RealmSwift

class Walk: Object {
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0
    @objc dynamic public private(set) var date = Date()
    public private(set) var locations = List<Location>() //list structure of walk's location objects
    //dynamic keyword is not used for optionals and lists
    
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["date", "duration" ]
    }
    
    convenience init(distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = Date()
        self.distance = distance
        self.duration = duration
        self.locations = locations
      
    }
    
    static func addWalkToRealm(distance: Double, duration: Int, locations: List<Location>) {
        REALM_QUEUE.sync { //method is executed on the REALM_QUEUE thread, designated for database operations
            let walk = Walk(distance: distance, duration: duration, locations: locations)
            //creating walk object, to be added to database
            do { //error handling, as this is an error prone method
                let realm = try Realm() //establishing connection to database
                try realm.write {
                    realm.add( walk )
                    try realm.commitWrite() //adding object to database confirmed
                }
            } catch {
                debugPrint("Error adding object to realm: \(error.localizedDescription)") //error message
            }
        }
    }
    
    static func getAllWalks() -> Results<Walk>? {   // returns results data type(similar to dictionary) of walk objects
        do {
            let realm = try Realm() // instance of a realm database
            return realm.objects(Walk.self).sorted(byKeyPath: "date", ascending: false)
            //returns array of walk objects, sorted by date field
        } catch {
            debugPrint("Error when getting all walks from realm: \(error)")
            return nil //sends error message incase function isn't possible
        }
    }
    
}

    
    
    
   
    
   

