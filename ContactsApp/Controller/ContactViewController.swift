//
//  ContactViewController.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 12.08.2020.
//  Copyright © 2020 Никита Дмитриев. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    var contact: Contacts!
    
    @IBOutlet weak var lableName: UILabel!
    
    
    @IBOutlet weak var labelDate: UILabel!
    
    
    @IBOutlet weak var labelTemperament: UILabel!
    
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var phone: UIButton! {
        didSet {
            
        }
    }
    
//    @IBAction func phonePush(_ sender: UIButton) {
//        sender.setTitle("\(contact.phone)", for: .normal)
//        callNumber(number: contact.phone)
//
//    }
//
//    func callNumber(number : String) {
//
//        if let url = URL(string: "tel://\(number)") {
//            if #available(iOS 10, *) {                          // проверка версии иос
//                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
//                    print(success)})
//            } else {
//                let success = UIApplication.shared.openURL(url)
//                print(success)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      phone.setTitle("\(contact.phone)", for: .normal)
        lableName.text = contact.name
        //labelDate.text = contact.educationPeriod
        labelText.text = contact.biography

        labelTemperament.text = String("\(contact.temperament)")
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
