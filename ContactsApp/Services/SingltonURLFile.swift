//
//  SingltonURLFile.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 12.03.2021.
//  Copyright © 2021 Никита Дмитриев. All rights reserved.
//

import Foundation

class Session: CustomStringConvertible {
    
    static let shared = Session()
    private init() {}
    
    var urlFile: String = ""
    
    var description: String {
        return "id: \(urlFile)"
    }
    
}
