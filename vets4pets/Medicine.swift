//
//  Medicine.swift
//  IA1
//
//  Created by Snigdha Tiwari  on 21/12/23.
//

import Foundation
import RealmSwift

class Medicine: Object {
    
    @objc dynamic var medicineName: String = ""
    @objc dynamic var petSpecies: String = ""
    @objc dynamic var commonName: String = ""
    @objc dynamic var stock: Int = 0
    @objc dynamic var dateCreated: Date = Date()
    
  

    convenience init(medicineName: String, petSpecies: String, commonName: String, stock: Int, dateCreated: Date) {
       self.init()
        self.medicineName = medicineName
        self.petSpecies = petSpecies
        self.commonName = commonName
        self.stock = stock
        self.dateCreated = Date()
      
   }
}
