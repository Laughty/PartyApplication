//
//  PartiesList.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import ObjectMapper
/*
 TODO:
 implementation
 - list of parties
 */

struct PartiesList: Mappable {
    var parties: [Party]
    
    init(parties: [Party]) {
        self.parties = parties
    }
    
    init?(map: Map) {
        fatalError()
    }
    
    mutating func mapping(map: Map) {
       parties <- map["parties"]
    }
}
