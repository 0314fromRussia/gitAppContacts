//
//  ContactViewController.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 12.08.2020.
//  Copyright © 2020 Никита Дмитриев. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    var contact: Contact!

    @IBOutlet weak var lableName: UILabel!
    
    
    @IBOutlet weak var labelDate: UILabel!
    
    
    @IBOutlet weak var labelTemperament: UILabel!
    
    
    @IBOutlet weak var labelText: UILabel!
    
    
    @IBAction func pushPhone(_ sender: UIButton) {
        func dialNumber(number : String) {

         if let url = URL(string: "tel://\(number)"),
           UIApplication.shared.canOpenURL(url) {
              if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
               } else {
                   UIApplication.shared.openURL(url)
               }
           } else {
                    // add error message here
           }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lableName.text = contact.name
        labelDate.text = contact.educationPeriod
        labelText.text = contact.biography
        
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
