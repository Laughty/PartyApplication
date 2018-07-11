//
//  FriendsListVC.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit

// Implement as TableViewController

/*
 TODO:
 implementation
 - View controller showing, list of friends
 */

class FriendsListVC: UITableViewController {
    
    let numberOfSections = 1
    
    var friends: [FriendVMProtocol] = []
    var selectedFriendIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: FriendCellItem.CellReusableIdentifier, bundle: nil), forCellReuseIdentifier: FriendCellItem.CellReusableIdentifier)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCellItem.CellReusableIdentifier) as! FriendCellItem
        cell.friendVM = friends[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedFriendIndex = indexPath.row
        performSegue(withIdentifier: StoryboardSegues.ToFriendDetails, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && selectedFriendIndex != nil {
                let destinationVC = segue.destination as! FriendDetailsVC
                destinationVC.friend = friends[selectedFriendIndex!]
                selectedFriendIndex = nil
            }
        
    }
    
}
