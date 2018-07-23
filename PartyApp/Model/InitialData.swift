//
//  InitialData.swift
//  PartyApp
//
//  Created by user1 on 19.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import AlamofireCoreData
struct InitialData : Wrapper {

    
    
    var friends: Many<Friends>!
    var parties: Many<Parties>!
    
    
    mutating func map(_ map: Map) {
        
        self.friends <- map["friends"]
        self.parties <- map["parties"]
    }
    init () {}
    
}
