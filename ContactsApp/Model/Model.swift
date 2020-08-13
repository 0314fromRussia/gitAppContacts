//
//  Model.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 12.07.2020.
//  Copyright © 2020 Никита Дмитриев. All rights reserved.
//

import Foundation

var contacts: [Contact] {
    
    let data = try? Data(contentsOf: urlToData)
    if data == nil {
        return []
    }
    let rootDictionary = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String, Any>]
    if rootDictionary == nil {
        return []
    }
    
    //let array = rootDictionary! as! [Dictionary<String, Any>]
    var returnArray: [Contact] = []
    
    for dict in rootDictionary! {
        let newContacts = Contact(dictionary: dict)
        returnArray.append(newContacts)
    }
    return returnArray
}

//https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-01.json

var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

func loadContacts(completionHandler: (() -> Void)?) { // загружаем джейсон
    
    let url = URL(string: "https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-01.json")
    let session = URLSession(configuration: .default)
    
    let downloadTask = session.downloadTask(with: url!) { (urlFile, response, error) in
        if urlFile != nil {
            try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
            
            print(contacts.count)
            completionHandler?()
        }
    }
    downloadTask.resume()
}

