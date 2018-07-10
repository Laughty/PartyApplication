//
//  PartiesListVM.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation

/*
 TODO:
 implementation
 - View model for list of parties
 */

protocol PartiesListProtocol {
    var parties: [PartyVMProtocol] {get set}
}

class PartiesListVM: PartiesListProtocol {
    
    var parties: [PartyVMProtocol]
    
    init(parties: [PartyVMProtocol]) {
        self.parties = parties
    }
    
}
