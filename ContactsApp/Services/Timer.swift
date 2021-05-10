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
            
            func calculateTime() {
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
            if oldDateArray[1] == ":" && oldDateArray[oldDateArray.count-2] == ":" && currentDateArray[currentDateArray.count-2] == ":" && currentDateArray[1] == ":" {     // если у нас время загрузки х:х - х:х
                oldDateArray.insert("0", at: 0)
                currentDateArray.insert("0", at: 0)
                oldDateArray.append("0")
                currentDateArray.append("0")
                calculateTime()
                
            }
            if oldDateArray[1] == ":" && oldDateArray[oldDateArray.count-2] == ":" && currentDateArray[currentDateArray.count-2] == ":" {     // если у нас время загрузки х:х - хх:х
                oldDateArray.insert("0", at: 0)
                oldDateArray.append("0")
                currentDateArray.append("0")
                calculateTime()
                
            }
            if oldDateArray[1] == ":" && oldDateArray[oldDateArray.count-2] == ":" && currentDateArray[1] == ":" {     // если у нас время загрузки х:х - х:хх
                oldDateArray.insert("0", at: 0)
                oldDateArray.append("0")
                currentDateArray.insert("0", at: 0)
                calculateTime()
                
            }
            if oldDateArray[1] == ":" && currentDateArray[currentDateArray.count-2] == ":" && currentDateArray[1] == ":" {     // если у нас время загрузки х:хх - х:х
                oldDateArray.insert("0", at: 0)
                currentDateArray.insert("0", at: 0)
                currentDateArray.append("0")
                calculateTime()
                
            }
            if oldDateArray[oldDateArray.count-2] == ":" && currentDateArray[currentDateArray.count-2] == ":" && currentDateArray[1] == ":" {     // если у нас время загрузки хх:х - х:х
                oldDateArray.append("0")
                currentDateArray.insert("0", at: 0)
                currentDateArray.append("0")
                calculateTime()
                
            }
            if oldDateArray[oldDateArray.count-2] == ":" && currentDateArray[currentDateArray.count-2] == ":" && currentDateArray[1] == ":" {     // если у нас время загрузки хх:х - х:х
                oldDateArray.append("0")
                currentDateArray.insert("0", at: 0)
                currentDateArray.append("0")
                calculateTime()
                
            }
            if currentDateArray[currentDateArray.count-2] == ":" && currentDateArray[1] == ":" {     // если у нас время загрузки хх:хх - х:х
                currentDateArray.insert("0", at: 0)
                currentDateArray.append("0")
                calculateTime()
                
            }
            if oldDateArray[oldDateArray.count-2] == ":" && oldDateArray[1] == ":" {     // если у нас время загрузки х:х - хх:хх
                oldDateArray.append("0")
                oldDateArray.insert("0", at: 0)
                calculateTime()
                
            }
            if oldDateArray[oldDateArray.count-2] == ":" && currentDateArray[currentDateArray.count-2] == ":" {     // если у нас время загрузки хх:х - хх:х
                oldDateArray.append("0")
                currentDateArray.append("0")
                calculateTime()
                
            }
            if oldDateArray[1] == ":" && currentDateArray[1] == ":" {     // если у нас время загрузки х:хх - х:хх
                oldDateArray.insert("0", at: 0)
                currentDateArray.insert("0", at: 0)
                calculateTime()
                
            }
            if oldDateArray[oldDateArray.count-2] == ":" && currentDateArray[1] == ":" {     // если у нас время загрузки хх:х - х:хх
                oldDateArray.append("0")
                currentDateArray.insert("0", at: 0)
                calculateTime()
                
            }
            if oldDateArray[1] == ":" && currentDateArray[currentDateArray.count-2] == ":" {     // если у нас время загрузки х:хх - хх:х
                oldDateArray.insert("0", at: 0)
                currentDateArray.append("0")
                calculateTime()
                
            }
            if currentDateArray[currentDateArray.count-2] == ":"  {     // если у нас время загрузки хх:хх - хх:х
                currentDateArray.append("0")
                calculateTime()
                
            }
            if oldDateArray[oldDateArray.count-2] == ":" {      // если у нас время загрузки хх:х - хх:хх
                oldDateArray.append("0")
                calculateTime()
            }
            if currentDateArray[1] == ":" {         // если у нас время загрузки хх:хх - х:хх
                currentDateArray.insert("0", at: 0)
                calculateTime()
            }
            if oldDateArray[1] == ":" {         // если у нас время загрузки х:хх - хх:хх
                oldDateArray.insert("0", at: 0)
                calculateTime()
            } else {        // если у нас время загрузки хх:хх - хх:хх
                calculateTime()
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

