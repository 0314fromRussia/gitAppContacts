//
//  ContactViewController.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 12.08.2020.
//  Copyright © 2020 Никита Дмитриев. All rights reserved.
//

import UIKit
import RealmSwift

class ContactViewController: UIViewController {
    
    var contact: Contacts!
    
    @IBOutlet weak var lableName: UILabel!
    
    
    @IBOutlet weak var labelDate: UILabel!
    
    
    @IBOutlet weak var labelTemperament: UILabel!
    
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var phone: UIButton!
    
    @IBAction func phonePush(_ sender: UIButton) {
        
        callNumber(number: contact.phone)
        
    }
    
    func callNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)") {
            if #available(iOS 10, *) {                          // проверка версии иос
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                                            print(success)})
            } else {
                let success = UIApplication.shared.openURL(url)
                print(success)
            }
        }
    }
    let realm = try! Realm()
    
    func fetchPeriod() -> String {
        let period = realm.objects(EducationPeriod.self).first
        let start = period?["start"]
        let end = period?["end"]
        return String("\(String(describing: start))" + "-" + "\(String(describing: end))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phone.setTitle("\(contact.phone)", for: .normal)
        lableName.text = contact.name
        labelText.text = contact.biography
        labelDate.text =  fetchPeriod()
        labelTemperament.text = String("\(contact.temperament)")
    }
}
