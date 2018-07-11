//
//  Friend.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit

struct Friend {
    
    let id: String
    let name: String
    let surname: String
    let likes: Int
    let description: String
    let photo: UIImage
    let phone: String
    let email: String
    
    init(id: String, name: String, surname: String, likes: Int, description: String, photo: UIImage, phone: String, email: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.likes = likes
        self.description = description
        self.photo = photo
        self.phone = phone
        self.email = email
    }
}

