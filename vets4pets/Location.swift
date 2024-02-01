//
//  Location.swift
//  IA
//
//  Created by Snigdha Tiwari  on 27/07/23.
//

import Foundation
import RealmSwift

class Location: Object {
    
    //dynamic allows variable to be accessor of realm databse
    //private is encapsulation
    @objc dynamic public private(set) var latitude = 0.0 //latitude of location
    @objc dynamic public private(set) var longitude = 0.0 //longitude of location
    
    convenience init(latitude: Double, longitude: Double) { //initializer of object
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
    
}


