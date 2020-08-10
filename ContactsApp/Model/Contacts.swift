//
//  Contacts.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 12.07.2020.
//  Copyright © 2020 Никита Дмитриев. All rights reserved.
//

import Foundation

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

enum Temperament {
    
    case melancholic, phlegmatic, sanguine, choleric
}

struct Contact {
    var id: String
    var name: String
    var phone: String
    var height: Float
    var biography: String
    var temperament: Temperament
    var educationPeriod: String
    
    init(dictionary: Dictionary <String, Any>) {
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        phone = dictionary["phone"] as? String ?? ""
        height = dictionary["height"] as? Float ?? 0
        biography = dictionary["biography"] as? String ?? ""
        temperament = dictionary["temperament"] as? Temperament ?? .choleric
        educationPeriod = (dictionary["educationPeriod"] as? Dictionary<String,String> ?? ["":""])["start"] as? String ?? ""
    }
    
}
