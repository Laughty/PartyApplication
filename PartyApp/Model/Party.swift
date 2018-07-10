//
//  Party.swift
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
 - id
 - location
 - time
 - title
 - description
 - image
 */

struct Party {
    
    let id: String
    let location: String
    let time: Date
    let title: String
    let description: String
    let image: UIImage
    
    init(id: String, location: String, time: Date, title: String, description: String, image: UIImage) {
        self.id = id
        self.location = location
        self.time = time
        self.title = title
        self.description = description
        self.image = image
    }
    
    
    
}
