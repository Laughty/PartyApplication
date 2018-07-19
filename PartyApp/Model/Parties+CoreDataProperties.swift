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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Parties> {
        return NSFetchRequest<Parties>(entityName: "Parties")
    }
    
    @nonobjc public class func fetchRequestBy(title: String) -> NSFetchRequest<Parties> {
        let request = NSFetchRequest<Parties>(entityName: "Parties")
        let predicate = NSPredicate(format: "title = %@",title)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        return request
    }
    @nonobjc public class func fetchRequestBy(id: Int) -> NSFetchRequest<Parties> {
        let request = NSFetchRequest<Parties>(entityName: "Parties")
        let predicate = NSPredicate(format: "id = %@",id)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        return request
    }
    

    @NSManaged public var desc: String?
    @NSManaged public var image: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var time: NSDate?
    @NSManaged public var title: String?

}
