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
    
    var urlFile: String = "https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-01.json"
    
    var description: String {
        return "id: \(urlFile)"
    }
    
}
