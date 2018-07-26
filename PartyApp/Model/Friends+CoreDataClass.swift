//
//  Friends+CoreDataClass.swift
//  PartyApp
//
//  Created by user1 on 19/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//
//

import Foundation
import CoreData


public class Friends: NSManagedObject {

    enum FriendsPredicateFactory {
        case name(String)
        case id(Int)
        
        var predicate: NSPredicate {
            switch self {
            case .id(let id):
                return NSPredicate(format: "id = %@",id)


            case .name(let name):
                return NSPredicate(format: "name = %@",name)

            }
        }
    }

    
    
}


