//
//  Friends+CoreDataProperties.swift
//  PartyApp
//
//  Created by user1 on 19/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//
//

import Foundation
import CoreData


extension Friends {

    @nonobjc public class func makePredicateWith(name: String) -> NSPredicate {
        return NSPredicate(format: "name = %@",name)
    }
    @nonobjc public class func makePredicateWith(id: Int) -> NSPredicate {
        return NSPredicate(format: "id = %@",id)
    }

   

    
    @NSManaged public var desc: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var likes: Int32
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var surname: String?

}


