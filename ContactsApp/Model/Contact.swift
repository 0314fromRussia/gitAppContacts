//
//  Contact.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 08.02.2021.
//  Copyright © 2021 Никита Дмитриев. All rights reserved.
//

import Foundation
import RealmSwift

/*
 {
 "id": "5bbb009d5d052e0b9258c316",
 "name": "Summer Greer",
 "phone": "+7 (903) 425-3032",
 "height": 201.9,
 "biography": "Non culpa occaecat occaecat sit occaecat aliquip esse Lorem voluptate commodo veniam ipsum velit. Mollit sunt quis reprehenderit pariatur Lorem consequat magna. Nulla nostrud ad deserunt tempor proident enim exercitation sit ullamco aliquip.",
 "temperament": "sanguine",
 "educationPeriod": {
 "start": "2013-07-15T11:44:06-06:00",
 "end": "2007-08-09T08:26:05-06:00"
 }
 }
 */

enum Temperaments {
    
    case melancholic, phlegmatic, sanguine, choleric
}



class EducationPeriod: Object {
    
    @objc dynamic var start: String = ""
    @objc dynamic var end: String = ""
    var contacts = LinkingObjects(fromType: Contacts.self, property: "educationPeriod")
    
    convenience init(dictionary: Dictionary<String,Any>) {
        self.init()
        start = dictionary["start"] as? String ?? ""
        end = dictionary["end"] as? String ?? ""
        
    }
}

class Contacts: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var height: Float = 0
    @objc dynamic var biography: String = ""
    @objc dynamic var temperament: String = ""
    var educationPeriod = List<EducationPeriod>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    convenience init(dictionary: Dictionary <String, Any>) {
        self.init()
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        phone = dictionary["phone"] as? String ?? ""
        height = dictionary["height"] as? Float ?? 0
        biography = dictionary["biography"] as? String ?? ""
        temperament = dictionary["temperament"] as? String ?? ""
        educationPeriod = List<EducationPeriod>()
        
        if let educationPeriodDict = dictionary["educationPeriod"] as? Dictionary<String, Any> {
            educationPeriod.append(EducationPeriod(dictionary: educationPeriodDict))
            
        }
    }
}
