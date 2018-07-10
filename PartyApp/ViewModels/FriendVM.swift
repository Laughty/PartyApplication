//
//  FriendVM.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation

/*
 TODO:
 implementation
 - View model for friend details
 */

protocol FriendVMProtocol {
    
    var name: String { set get }
    var surname: String { set get }
    
}

class FriendVM: FriendVMProtocol {
    
    var name: String
    var surname: String
    
    init(friend: Friend) {
        
    }
    
}
