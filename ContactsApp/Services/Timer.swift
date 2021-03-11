//
//  Timer.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 11.03.2021.
//  Copyright © 2021 Никита Дмитриев. All rights reserved.
//

import Foundation


func currentTime() -> String {
    let date = Date()
    let calendar = Calendar.current
    let second = calendar.component(.second, from: date)
    let minutes = calendar.component(.minute, from: date)
    return "\(minutes):\(second)"
}


// MARK: - Предупреждение!!! Код ниже может вызывать головокружения, мигрень и прочие неприятные ощущения. Не рекомендовано лицам моложе 18 лет и беременным женщинам. По всем вопросам можно писать в тг @nikita0314

func loadingInOneMinute() {
    // создаем файл, куда запишем время запуска приложения и потом будем сравнивать с новым временем
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first   // получаем урл до документов
    print(documentsDirectory ?? "")
    let timeFile = documentsDirectory?.appendingPathComponent("TimeFile.txt").path          // содадим урл до нашего файла
    let date = currentTime().data(using: .utf8)            // переменная с датой
    print(date ?? "")
    
    if timeFile != nil {
        guard FileManager.default.fileExists(atPath: timeFile ?? "") else {     // проверим есть ли файл
            FileManager.default.createFile(atPath: timeFile ?? "", contents: date, attributes: nil) // созадим, если нет
            return
        }
        var oldDateMinutes1 = 0
        var oldDateMinutes2 = 0
        var oldDateSec1 = 0
        var oldDateSec2 = 0
        
        var currentDateMinutes1 = 0
        var currentDateMinutes2 = 0
        var currentDateSec1 = 0
        var currentDateSec2 = 0
        
        
        do {
            let oldDate = try String(contentsOfFile: timeFile ?? "")
            var oldDateArray = Array(oldDate)
            
            let currentDate = currentTime()
            var currentDateArray = Array(currentDate)
            
            if oldDateArray[1] == ":" {         // если у нас время прошлой загрузки х:хх
                oldDateArray.insert("0", at: 0)
                
                oldDateMinutes1 = Int(String("\(oldDateArray[0])")) ?? 0
                oldDateMinutes2 = Int(String("\(oldDateArray[1])")) ?? 0
                oldDateSec1 = Int(String("\(oldDateArray[3])")) ?? 0
                oldDateSec2 = Int(String("\(oldDateArray[4])")) ?? 0
                
                let sumOldSec = ((oldDateMinutes1 * 10 + oldDateMinutes2) * 60) + (oldDateSec1 * 10 + oldDateSec2)
                
                currentDateMinutes1 = Int(String("\(currentDateArray[0])")) ?? 0
                currentDateMinutes2 = Int(String("\(currentDateArray[1])")) ?? 0
                currentDateSec1 = Int(String("\(currentDateArray[3])")) ?? 0
                currentDateSec2 = Int(String("\(currentDateArray[4])")) ?? 0
                
                let sumCurrentSec = ((currentDateMinutes1 * 10 + currentDateMinutes2) * 60) + (currentDateSec1 * 10 + currentDateSec2)
                
                if (sumCurrentSec - sumOldSec) >= 60 {
                    let newDate = currentTime().data(using: .utf8)
                    print(newDate ?? "")
                    FileManager.default.createFile(atPath: timeFile ?? "", contents: newDate, attributes: nil)
                    loadContacts {
                        
                    }
                }
                
            }
            if currentDateArray[1] == ":" {         // если у нас время текущей загрузки х:хх
                currentDateArray.insert("0", at: 0)
                
                oldDateMinutes1 = Int(String("\(oldDateArray[0])")) ?? 0
                oldDateMinutes2 = Int(String("\(oldDateArray[1])")) ?? 0
                oldDateSec1 = Int(String("\(oldDateArray[3])")) ?? 0
                oldDateSec2 = Int(String("\(oldDateArray[4])")) ?? 0
                
                let sumOldSec = ((oldDateMinutes1 * 10 + oldDateMinutes2) * 60) + (oldDateSec1 * 10 + oldDateSec2)
                
                currentDateMinutes1 = Int(String("\(currentDateArray[0])")) ?? 0
                currentDateMinutes2 = Int(String("\(currentDateArray[1])")) ?? 0
                currentDateSec1 = Int(String("\(currentDateArray[3])")) ?? 0
                currentDateSec2 = Int(String("\(currentDateArray[4])")) ?? 0
                
                let sumCurrentSec = ((currentDateMinutes1 * 10 + currentDateMinutes2) * 60) + (currentDateSec1 * 10 + currentDateSec2)
                
                if (sumCurrentSec - sumOldSec) >= 60 {
                    let newDate = currentTime().data(using: .utf8)
                    print(newDate ?? "")
                    FileManager.default.createFile(atPath: timeFile ?? "", contents: newDate, attributes: nil)
                    loadContacts {
                        
                    }
                }
                
            }
            if oldDateArray[oldDateArray.count-2] == ":" {      // если у нас время прошлой загрузки хх:х
                
                oldDateArray.append("0")
                
                oldDateMinutes1 = Int(String("\(oldDateArray[0])")) ?? 0
                oldDateMinutes2 = Int(String("\(oldDateArray[1])")) ?? 0
                oldDateSec1 = Int(String("\(oldDateArray[3])")) ?? 0
                oldDateSec2 = Int(String("\(oldDateArray[4])")) ?? 0
                
                let sumOldSec = ((oldDateMinutes1 * 10 + oldDateMinutes2) * 60) + (oldDateSec1 * 10 + oldDateSec2)
                
                currentDateMinutes1 = Int(String("\(currentDateArray[0])")) ?? 0
                currentDateMinutes2 = Int(String("\(currentDateArray[1])")) ?? 0
                currentDateSec1 = Int(String("\(currentDateArray[3])")) ?? 0
                currentDateSec2 = Int(String("\(currentDateArray[4])")) ?? 0
                
                let sumCurrentSec = ((currentDateMinutes1 * 10 + currentDateMinutes2) * 60) + (currentDateSec1 * 10 + currentDateSec2)
                
                if (sumCurrentSec - sumOldSec) >= 60 {
                    let newDate = currentTime().data(using: .utf8)
                    print(newDate ?? "")
                    FileManager.default.createFile(atPath: timeFile ?? "", contents: newDate, attributes: nil)
                    loadContacts {
                    
                    }
                }
            }
            if currentDateArray[currentDateArray.count-2] == ":"  {     // если у нас время текущей загрузки хх:х
                
                currentDateArray.append("0")
                
                oldDateMinutes1 = Int(String("\(oldDateArray[0])")) ?? 0
                oldDateMinutes2 = Int(String("\(oldDateArray[1])")) ?? 0
                oldDateSec1 = Int(String("\(oldDateArray[3])")) ?? 0
                oldDateSec2 = Int(String("\(oldDateArray[4])")) ?? 0
                
                let sumOldSec = ((oldDateMinutes1 * 10 + oldDateMinutes2) * 60) + (oldDateSec1 * 10 + oldDateSec2)
                
                currentDateMinutes1 = Int(String("\(currentDateArray[0])")) ?? 0
                currentDateMinutes2 = Int(String("\(currentDateArray[1])")) ?? 0
                currentDateSec1 = Int(String("\(currentDateArray[3])")) ?? 0
                currentDateSec2 = Int(String("\(currentDateArray[4])")) ?? 0
                
                let sumCurrentSec = ((currentDateMinutes1 * 10 + currentDateMinutes2) * 60) + (currentDateSec1 * 10 + currentDateSec2)
                
                if (sumCurrentSec - sumOldSec) >= 60 {
                    let newDate = currentTime().data(using: .utf8)
                    print(newDate ?? "")
                    FileManager.default.createFile(atPath: timeFile ?? "", contents: newDate, attributes: nil)
                    loadContacts {
                    
                    }
                }
            } else {        // если у нас время загрузки хх:хх
                oldDateMinutes1 = Int(String("\(oldDateArray[0])")) ?? 0
                oldDateMinutes2 = Int(String("\(oldDateArray[1])")) ?? 0
                oldDateSec1 = Int(String("\(oldDateArray[3])")) ?? 0
                oldDateSec2 = Int(String("\(oldDateArray[4])")) ?? 0
                
                let sumOldSec = ((oldDateMinutes1 * 10 + oldDateMinutes2) * 60) + (oldDateSec1 * 10 + oldDateSec2)
                
                currentDateMinutes1 = Int(String("\(currentDateArray[0])")) ?? 0
                currentDateMinutes2 = Int(String("\(currentDateArray[1])")) ?? 0
                currentDateSec1 = Int(String("\(currentDateArray[3])")) ?? 0
                currentDateSec2 = Int(String("\(currentDateArray[4])")) ?? 0
                
                let sumCurrentSec = ((currentDateMinutes1 * 10 + currentDateMinutes2) * 60) + (currentDateSec1 * 10 + currentDateSec2)
                
                if (sumCurrentSec - sumOldSec) >= 60 {
                    let newDate = currentTime().data(using: .utf8)
                    print(newDate ?? "")
                    FileManager.default.createFile(atPath: timeFile ?? "", contents: newDate, attributes: nil)
                    loadContacts {
                       
                    }
                }
            }
            
            print(oldDate)
        } catch {
            print(error)
        }
        
        
        
        
        let newDate = currentTime().data(using: .utf8)
        print(newDate ?? "")
        FileManager.default.createFile(atPath: timeFile ?? "", contents: newDate, attributes: nil)
        
        
        
        
    }
}

