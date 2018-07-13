//
//  UserVM.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit

/*
 TODO:
 implementation
 - View model for user details, hadle account changes
 */

protocol UserVMProtocol {
    var name: String { set get }
    var surname: String { set get }
    var image: UIImage { set get }
    var description: String { set get }
    var phone: String { get set }
    var email: String { get set }
    var friendsIds: [String] { get set }
    var favoritePartiesIds: [String] { get set }
}

class UserVM: UserVMProtocol {
    var id: String
    var name: String
    var surname: String
    var image: UIImage
    var description: String
    var phone: String
    var email: String
    var friendsIds: [String]
    var favoritePartiesIds: [String]
    
    init(user: User) {
        self.id = String(user.id)
        self.name = user.name
        self.surname = user.surname
        self.description = user.description
        self.image = UIImage(named: user.photo)!
        self.phone = user.phone
        self.email = user.email
        self.friendsIds = user.friendsIds
        self.favoritePartiesIds = user.favoritePartiesIds
    }
}
