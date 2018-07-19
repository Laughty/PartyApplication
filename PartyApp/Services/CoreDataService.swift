//
//  CoreDataService.swift
//  PartyApp
//
//  Created by user1 on 18/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import CoreData
import AlamofireObjectMapper
import UIKit
import Alamofire

enum FetchDetail: String {
    case partyList = "Parties"
    case friendList = "Friends"
    
}

protocol CoreDataSaveable {
    
}



class CoreDataService {
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    
    
    func saveDataToCoreData(name:FetchDetail,dataObject:Any){
        switch name {
        case .friendList:
            
            cleanRecordForEntity(name: name)
            let friendList = dataObject as! FriendList
            friendList.friends.map(){ f in
                let entity = NSEntityDescription.entity(forEntityName: name.rawValue, in: self.moc)
                let newFriend = NSManagedObject(entity: entity!, insertInto: self.moc) as? Friends
                newFriend?.id = Int32(f.id)!
                newFriend?.desc = f.description
                newFriend?.likes = Int32(f.likes)
                newFriend?.name = f.name
                newFriend?.phone = f.phone
                newFriend?.surname = f.surname
                newFriend?.image = f.image
            }
            do {
                try self.moc.save()
            } catch {
                print("Failed saving")
            }

            
        case .partyList:
            cleanRecordForEntity(name: name)
            let partyList = dataObject as! PartiesList
            partyList.parties.map(){ p in
                let entity = NSEntityDescription.entity(forEntityName: name.rawValue, in: self.moc)
                let newParty = NSManagedObject(entity: entity!, insertInto: self.moc) as? Parties
                newParty?.desc = p.description
                newParty?.latitude = p.location[0]
                newParty?.longitude = p.location[1]
                newParty?.time = p.time
                newParty?.title = p.title
                newParty?.image = p.image
            }
            do {
                try self.moc.save()
            } catch {
                print("Failed saving")
            }

        default:
            return
        }
    }
    private func cleanRecordForEntity(name:FetchDetail){
        switch name {
            //TODO
        case .friendList:
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: name.rawValue)
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            do{
                _ = try self.moc.execute(request)
            }catch {
                print("Failed")
            }
        case .partyList:
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: name.rawValue)
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            do{
                _ = try self.moc.execute(request)
            }catch {
                print("Failed")
            }
        }
    }
    
    
    func fetchDetailWith(name:FetchDetail, predicate:NSPredicate?) -> Any?{
        switch name {
        case .friendList:
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: name.rawValue)
            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            do {
                return try moc.fetch(request)
            }catch{
                    print("Failed")
            }
        case .partyList:
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: name.rawValue)
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                do {
                    return try moc.fetch(request) 
                }catch{
                    print("Failed")
                }
        default:
            print("WARNING: Can't find entity")
            return nil
            
        }
     return nil
    }
    class var shared: CoreDataService {
        struct Static {
            static let instance = CoreDataService()
        }
        return Static.instance
    }
    
}
