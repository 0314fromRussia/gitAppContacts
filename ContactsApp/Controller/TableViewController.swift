//
//  TableViewController.swift
//  ContactsApp
//
//  Created by Никита Дмитриев on 12.07.2020.
//  Copyright © 2020 Никита Дмитриев. All rights reserved.
//

import UIKit
import RealmSwift
import Toast_Swift


class TableViewController: UITableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var filteredContacts = [Contacts]()
    
    var items: [Contacts] = []
    
    var filteredItems: [Contacts] = []
   
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingInOneMinute()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // показываем тост, когда не смогли распарсить джейсон
        if parse() == nil {
            DispatchQueue.main.async {
                self.showTost()
            }
        }
    
        // грузим контакты
        loadContacts {
            DispatchQueue.main.async {
                // показываем тост, когда нет урла
                if Session.shared.urlFile == "" {
                    self.showTost()
                }
                self.tableView.reloadData()
            }
            self.newItems()
        }
        
        // поисковой контроллер
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func newItems() {
        items = fetchRealm()
    }
    
    func showTost() {
        
        self.view.makeToast("Нет подключения к сети", duration: 10.0, position: .center)
    }
    
    func fetchRealm() -> [Contacts] {
        let realm = try! Realm()
        return Array(realm.objects(Contacts.self).sorted(byKeyPath: "name", ascending: true))
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredContacts.count
        }
        return fetchRealm().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var contact: Contacts
        if isFiltering {
            contact = filteredContacts[indexPath.row] //получаем контакт для ячейки
        } else {
            contact = fetchRealm()[indexPath.row]
        }
        
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
                
                var contact: Contacts
                if isFiltering {
                    contact = filteredContacts[indexPath.row]
                } else {
                    contact = fetchRealm()[indexPath.row]
                }
                
                (segue.destination as? ContactViewController)?.contact = contact
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
}

// ищем контакт по имени или телефону

extension TableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchName(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchName(_ searchText: String) {
        
        filteredContacts = fetchRealm().filter({ (contact: Contacts) -> Bool in
            guard contact.name.lowercased().contains(searchText.lowercased()) || contact.phone.contains(searchText) else {
                return false
            }
            return true
        })
        tableView.reloadData()
    }
}
