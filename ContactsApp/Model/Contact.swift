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
    
    init(dictionary: Dictionary<String,Any>) {
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
    @objc dynamic var educationPeriod: [EducationPeriod]
    
    
    init(dictionary: Dictionary <String, Any>) {
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        phone = dictionary["phone"] as? String ?? ""
        height = dictionary["height"] as? Float ?? 0
        biography = dictionary["biography"] as? String ?? ""
        temperament = dictionary["temperament"] as? String ?? ""
        educationPeriod = []
        for dictPeriod in dictionary["educationPeriod"] as? [Dictionary<String,Any>] ?? [] {
            educationPeriod.append(EducationPeriod(dictionary: dictPeriod))
        }
        
    }
}

func parse(pathForFile: String) -> [Contacts] {
    
    let data = try? Data(contentsOf: urlToData) // получили бинарные данные из url
    if data == nil {
        return []
    }
    var urlToData: URL {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json" // возвращаем путь до директории, где url
        let urlPath = URL(fileURLWithPath: path) // из стринга конвертируем в url
        return urlPath
    }
    
    let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [Any]
    print(dictionary)
    return []
}
    
