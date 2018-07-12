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

class FriendListVC: UITableViewController{
    
    var friends: [FriendsProtocol] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    
//    private func mockData(){
//        
//        for index in 1...3 {
//            let friend = Friend(id: <#T##String#>, name: <#T##String#>, surname: <#T##String#>)
//        }
//        
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "CELL")!
    }
    
    
}
