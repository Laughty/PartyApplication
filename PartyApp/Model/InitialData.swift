//
//  InitialData.swift
//  PartyApp
//
//  Created by user1 on 19.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import ObjectMapper

struct InitialData : Mappable {
    
    var friends: [Friend] = []
    var parties: [Party] = []
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        friends <- map["friends"]
        parties <- map["parties"]
    }
    
}
