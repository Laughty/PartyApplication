//
//  FriendVM.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit

/*
 TODO:
 implementation
 - View model for friend details
 */

protocol FriendVMProtocol {
    
    var name: String { set get }
    var surname: String { set get }
    var image: UIImage { set get }
    var description: String { set get }
    var likes: Int { get set }
    var phone: String { get set }
    var email: String { get set }
    
}

class FriendVM: FriendVMProtocol {
    
    var id: String
    var name: String
    var surname: String
    var likes: Int
    var description: String
    var image: UIImage
    var phone: String
    var email: String
    
    init(friend: Friend) {
        self.id = friend.id
        self.name = friend.name
        self.surname = friend.surname
        self.description = friend.description
        self.likes = friend.likes
        self.image = UIImage(named: friend.image)!
        self.phone = friend.phone
        self.email = friend.email
    }
    
}
