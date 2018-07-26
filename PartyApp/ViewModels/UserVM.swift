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
    var id: String = ""
    var name: String = "John"
    var surname: String = "Doe"
    var image: UIImage = UIImage()
    var description: String = "Mocky guy."
    var phone: String = "123456789"
    var email: String = "j.doe@mail.com"
    var friendsIds: [String] = []
    var favoritePartiesIds: [String] = []
    
    
    
    
}
