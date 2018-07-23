//
//  AbstractService.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

fileprivate extension NSManagedObject {
    class func entityName() -> String {
        return self.entity().name!
    }
}

enum Result<T> {
    case success(T)
    case error(Error?)
}

protocol AbstractServiceProtocol {
    func fetchRequest<T: NSManagedObject>(with predicate: NSPredicate?) -> [T]?
}

class AbstractService: AbstractServiceProtocol {
    func fetchRequest<T>(with predicate: NSPredicate?) -> [T]? where T: NSManagedObject {
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entity().name!)
        
        do {
            request.predicate = predicate
            let requestResult = try moc.fetch(request) as! [T]
            return requestResult
        } catch {
            print("Couldn't find proper entity")
            return nil
        }
    }
    
}

