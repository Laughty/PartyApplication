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
    
    var id: String = ""
    var location: [Double]  = []
    var time: Date  = Date()
    var title: String  = ""
    var description: String  = ""
    var image: String = "person"
    
    init(id: String, location: [Double], time: Date, title: String, description: String, image: String) {
        self.id = id
        self.location = location
        self.time = time
        self.title = title
        self.description = description
        self.image = image
    }
    
    init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
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
