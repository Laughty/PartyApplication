//
//  Parties+CoreDataProperties.swift
//  PartyApp
//
//  Created by user1 on 19/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//
//

import Foundation
import CoreData


extension Parties {

    @nonobjc public class func makePredicateWith(title: String) -> NSPredicate {
        return NSPredicate(format: "title = %@",title)
    }
    @nonobjc public class func makePredicateWith(id: Int) -> NSPredicate {
        return NSPredicate(format: "id = %@",id)
    }
    

    @NSManaged public var desc: String?
    @NSManaged public var image: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var time: NSDate?
    @NSManaged public var title: String?

}
