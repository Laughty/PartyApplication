//
//  Friend.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import ObjectMapper

struct Friend: Mappable {
    
    var id: String = ""
    var name: String = ""
    var surname: String = ""
    var likes: Int = 0
    var description: String = ""
    var image: String = ""
    var phone: String = ""
    var email: String = ""
    
    init(id: String, name: String, surname: String, likes: Int, description: String, photo: String, phone: String, email: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.likes = likes
        self.description = description
        self.image = photo
        self.phone = phone
        self.email = email
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        surname <- map["surname"]
        likes <- map["likes"]
        description <- map["description"]
        image <- map["photo"]
        phone <- map["phone"]
        email <- map["email"]
    }
}

