//
//  FriendsVM.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation

/*
 TODO:
 implementation
 - View model for friends list
 */

protocol FriendsProtocol {
    var friend:[FriendVM] {get set}
}

class FriendsVM: FriendsProtocol {
    
    var friend: [FriendVM]
    
    init(friends:[FriendVM]){
        self.friend = friends
    }
}
