//
//  User.swift
//  PartyApp
//
//  Created by user1 on 13/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    
    var id: Int = 0
    var name: String = ""
    var surname: String = ""
    var likes: Int = 0
    var description: String = ""
    var photo: String = ""
    var email: String = ""
    var phone: String = ""
    var friendsIds: [String] = []
    var favoritePartiesIds: [String] = []

    init(id: Int, name: String, surname: String, likes: Int, description: String, photo: String, email: String, phone: String, friendsIds: [String], favoritePartiesIds: [String]) {
        self.id = id
        self.name = name
        self.surname = surname
        self.likes = likes
        self.description = description
        self.photo = photo
        self.email = email
        self.phone = phone
        self.friendsIds = friendsIds
        self.favoritePartiesIds = favoritePartiesIds
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        surname <- map["surname"]
        likes <- map["likes"]
        description <- map["description"]
        photo <- map["photo"]
        email <- map["email"]
        phone <- map["phone"]
        friendsIds <- map["friends_ids"]
        favoritePartiesIds <- map["favorite_parties_ids"]
    }
}
