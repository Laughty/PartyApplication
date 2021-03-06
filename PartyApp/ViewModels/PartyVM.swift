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
    var title: String { get set }
    var image: UIImage { get set }
    var description: String { get set }
//    var location: [Double] { get set }
    var latitude: Double {get set}
    var longitude: Double {get set}
    var time: Date { get set }
}

class PartyVM: PartyVMProtocol {
    var title: String
    var image: UIImage
    var description: String
    var latitude: Double
    var longitude: Double
    var time: Date
    
    init(party: Parties){
        self.image = UIImage(named: party.image!)!
        self.title = party.title!
        self.description = party.desc!
        self.latitude = party.latitude
        self.longitude = party.longitude
        self.time = party.time! as Date
    }
    
}

