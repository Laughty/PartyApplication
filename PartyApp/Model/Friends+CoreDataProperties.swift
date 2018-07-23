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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friends> {
        return NSFetchRequest<Friends>(entityName: "Friends")
    }
    @nonobjc public class func fetchRequestBy(name: String) -> NSFetchRequest<Friends> {
        let request = NSFetchRequest<Friends>(entityName: "Friends")
        let predicate = NSPredicate(format: "name = %@",name)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        return request
    }
    @nonobjc public class func fetchRequestBy(id: Int) -> NSFetchRequest<Friends> {
        let request = NSFetchRequest<Friends>(entityName: "Friends")
        let predicate = NSPredicate(format: "id = %@",id)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        return request
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


