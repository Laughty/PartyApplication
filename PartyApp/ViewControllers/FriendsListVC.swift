//
//  FriendsListVC.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// Implement as TableViewController

/*
 TODO:
 implementation
 - View controller showing, list of friends
 */

class FriendsListVC: UITableViewController, UISearchResultsUpdating {
    
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let numberOfSections = 1
    
    var friends: [FriendVMProtocol] = []
    var selectedFriendIndex: Int?
    var filteredFriends: [FriendVMProtocol] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("FriendsListVCTitle", comment: "")
        
        tableView.registerReusableCell(FriendCellItem.self)
        
        _ = FriendsServices.shared.fetchAllFriends().map {
            friends.append(FriendVM(friend: $0))
        }
        
        filteredFriends = friends
        searchControllerSetup()
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(FriendCellItem.self)!
        cell.friendVM = filteredFriends[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedFriendIndex = indexPath.row
        performSegue(withIdentifier: StoryboardSegues.ToFriendDetails, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        searchController.isActive = false;
        if segue.identifier != nil && selectedFriendIndex != nil {
            let destinationVC = segue.destination as! FriendDetailsVC
            destinationVC.friend = friends[selectedFriendIndex!]
            selectedFriendIndex = nil
        }
        
    }
    func searchControllerSetup() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        var inname = false
        var insurname = false
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredFriends = friends.filter { friend in
                inname = friend.name.lowercased().contains(searchText.lowercased())
                insurname = friend.surname.lowercased().contains(searchText.lowercased())
                return inname||insurname
            }
            
        } else {
            filteredFriends = friends
        }
        tableView.reloadData()
    }
    
}

extension UITableView {
  
    func registerReusableCell<Cell: UITableViewCell>(_ cellType: Cell.Type) {
        
        register(Cell.nib, forCellReuseIdentifier: Cell.cellReusableIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(_ cellType: Cell.Type)-> Cell? {
        
        return dequeueReusableCell(withIdentifier: Cell.cellReusableIdentifier) as? Cell
    }
}
