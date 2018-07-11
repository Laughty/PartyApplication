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
 */

protocol PartyVMProtocol {
    var title: String {get set}
    var image: UIImage {get set}
}

class PartyVM: PartyVMProtocol {
    var title: String
    var image: UIImage
    
    init(party: Party){
        self.image = party.image
        self.title = party.title
    }
    
}

