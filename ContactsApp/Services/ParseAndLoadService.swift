//
//  Model.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 12.07.2020.
//  Copyright © 2020 Никита Дмитриев. All rights reserved.
//

import Foundation
import RealmSwift

//https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-01.json

//var urlToData: URL {
//    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json" // возвращаем путь до директории, где url
//    let urlPath = URL(fileURLWithPath: path) // из стринга конвертируем в url
//    return urlPath
//}


func loadContacts(completionHandler: (() -> Void)?) { // загружаем json
    
    let url = URL(string: "https://raw.githubusercontent.com/SkbkonturMobile/mobile-test-ios/master/json/generated-01.json")
    let session = URLSession(configuration: .default)
    
    

    let downloadTask = session.downloadTask(with: url!) { (urlFile, response, error) in
        if urlFile != nil { //сохраняем url (тут нил при первичном запуске)
            
//            Session.shared.urlFile = String(describing: urlToData) // передаем в синглтон урл, чтобы потом показать тост, если это необходимо и урла нет
//            print(Session.shared.urlFile)
//            try? FileManager.default.copyItem(at: urlFile!, to: urlToData)
            
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json" // возвращаем путь до директории, где url
            let urlPath = URL(fileURLWithPath: path) // из стринга конвертируем в url
        
            try? FileManager.default.copyItem(at: urlFile!, to: urlPath)
            parse()

            completionHandler?()
        }
    }
    downloadTask.resume()
}


func parse() -> [Contacts]? {
    
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json" // возвращаем путь до директории, где url
    let urlPath = URL(fileURLWithPath: path) // из стринга конвертируем в url
    
    var data: Data?

    do{
        data = try Data(contentsOf: urlPath) // получили бинарные данные из url
    } catch {
        print("Ошибка получения Data: \(error.localizedDescription)")

        return nil
    }

    guard let dataReal = data else {
        print("Error  ")
        return nil
    }

    var dictionary: [[String:Any]] = [[:]]

    do {
        guard let dict = try JSONSerialization.jsonObject(with: dataReal, options: .allowFragments) as? [[String:Any]] else {
            print("Error..JSON не преабразуется к формату [[String:Any]]")
            return nil
        }
        dictionary = dict
    } catch {
        print("Ошибка парсинга JSON: \(error.localizedDescription)")
        return nil
    }

    var returnArray: [Contacts] = []
    for dict in dictionary { // парсим и добавляем в массив
        returnArray.append(Contacts(dictionary: dict))
    }

    do {                                // добавляем распаршенный массив в реалм
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)        // задали конфигурацию, чтобы база удалялась при изменении модели
        let realm = try Realm(configuration: config)
        realm.beginWrite()
        realm.add(returnArray, update: .modified)           // modified перезаписывает объект с измененными проперти
        try realm.commitWrite()
        print(realm.configuration.fileURL ?? "")
    } catch {
        print(error)
    }

    return returnArray
}



func establishUserDefaultsHaveBeenVerifed() -> Bool {
     let defaults = UserDefaults.standard
     if let _ = defaults.string(forKey: "userDefaultsHaveBeenVerified"){
         print("user defaults were already verified")
         return true
      }else{
         defaults.set(true, forKey: "userDefaultsHaveBeenVerified")
         print("verified user defaults for first time since app was installed")
         return false
      }
 }

