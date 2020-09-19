//
//  TableViewController.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 12.07.2020.
//  Copyright © 2020 Никита Дмитриев. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    
   private let searchController = UISearchController(searchResultsController: nil)
    
    private var filteredContacts = [Contact]()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    //обновление списка контактов свайпом вниз
    @IBAction func refreshContacts(_ sender: Any) {
        loadContacts {
            DispatchQueue.main.async { // получаем доступ к главному потоку
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData() //обновляем после загрузки и парсинга
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // поисковой контроллер
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredContacts.count
        }
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var contact: Contact
        if isFiltering {
            contact = filteredContacts[indexPath.row] //получаем контакт для ячейки
        } else {
            contact = contacts[indexPath.row]
        }
        
        //let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name // заполняем ячейки
        cell.detailTextLabel?.text = contact.phone
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // когда нажали на ячейку
        performSegue(withIdentifier: "goToOneContact", sender: self) // переход по сигвею и нажатию
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // перед переходом после нажатия на ячейку
        
        if segue.identifier == "goToOneContact"{
            if let indexPath = tableView.indexPathForSelectedRow { // присваиваем значение выбранной ячейки
                
                var contact: Contact
                if isFiltering {
                    contact = filteredContacts[indexPath.row]
                } else {
                    contact = contacts[indexPath.row]
                }
                
                (segue.destination as? ContactViewController)?.contact = contact
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */

}

extension TableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchName(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchName(_ searchText: String) {
        
        filteredContacts = contacts.filter({ (contact: Contact) -> Bool in
            return contact.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
