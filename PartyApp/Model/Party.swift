//
//  Party.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

/*
 TODO:
 implementation
 - id
 - location
 - time
 - title
 - description
 - image
 */

struct Party: Mappable {
    
    var id: String
    var location: String
    var time: Date
    var title: String
    var description: String
    var image: UIImage
    
    init(id: String, location: String, time: Date, title: String, description: String, image: UIImage) {
        self.id = id
        self.location = location
        self.time = time
        self.title = title
        self.description = description
        self.image = image
    }
    
    init?(map: Map) {
        fatalError()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        location <- map["location"]
        time <- map["time"]
        title <- map["title"]
        description <- map["description"]
        image <- map["image"]
    }
    
}
