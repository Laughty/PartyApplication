//
//  PartyVM.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit
/*
 TODO:
 implementation
 - View model for describing party details
 let id: String
 let location: String
 let time: Date
 let title: String
 let description: String
 let image: UIImage
 */

protocol PartyVMProtocol {
    var title: String {get set}
    var image: UIImage {get set}
    var location: String {get set}
    var time: Date {get set}
    var description: String {get set}
}

class PartyVM: PartyVMProtocol {
    var location: String
    var time: Date
    var description: String
    var title: String
    var image: UIImage
    
    init(party: Party){
        self.image = party.image
        self.title = party.title
        self.location = party.location
        self.description = party.description
        self.time = party.time
    }
    
}

