//
//  FriendsList.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import ObjectMapper
/*
 TODO:
 implementation
- list of friends
 */

struct FriendList: Mappable, CoreDataSaveable {
    var friends: [Friend] = []
    
    init(friends: [Friend]) {
        self.friends = friends
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        friends <- map["friends"]
    }
}
