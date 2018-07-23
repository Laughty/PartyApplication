//
//  AlamofireService.swift
//  PartyApp
//
//  Created by user1 on 19.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import CoreData

class InitService {
    
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    class var shared: InitService {
        struct Static {
            static let instance = InitService()
        }
        return Static.instance
    }
    
    func getInitData(_ urlAdress: String) -> () {
        
        UserDefaults.standard.set(false, forKey: "IsDataInitialized")
        
        Alamofire.request(URL(string: urlAdress)!).responseObject{ (response: DataResponse<InitialData>) in
            guard let initData = response.result.value else { return }
            self.saveDataToCoreData(dataObject: initData)
            
            UserDefaults.standard.set(true, forKey: "IsDataInitialized")
        }
    }

    
    func saveDataToCoreData(dataObject:Any){
        cleanRecordForEntity()
        let initData = dataObject as! InitialData
        
        _ = initData.parties.map(){
            p in
            let entity = NSEntityDescription.entity(forEntityName: "Parties", in: self.moc)
            let newParty = NSManagedObject(entity: entity!, insertInto: self.moc) as? Parties
            newParty?.desc = p.description
            newParty?.latitude = p.latitude
            newParty?.longitude = p.longitude
            newParty?.setValue(p.time, forKey: "time")
            newParty?.title = p.title
            newParty?.image = p.image
        }
        _ = initData.friends.map(){ f in
            let entity = NSEntityDescription.entity(forEntityName: "Friends", in: self.moc)
            let newFriend = NSManagedObject(entity: entity!, insertInto: self.moc) as? Friends
            newFriend?.id = Int32(f.id)!
            newFriend?.desc = f.description
            newFriend?.likes = Int32(f.likes)
            newFriend?.name = f.name
            newFriend?.phone = f.phone
            newFriend?.surname = f.surname
            newFriend?.image = f.image
            newFriend?.email = f.email
        }
        do {
            try self.moc.save()
            print("Się udało!!!")
        } catch {
            print("Failed saving")
        }
    
    }
    private func cleanRecordForEntity(){
        
        var fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Friends")
        var request = NSBatchDeleteRequest(fetchRequest: fetch)
        do{
            _ = try self.moc.execute(request)
        }catch {
            print("Failed")
        }
        fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Parties")
        request = NSBatchDeleteRequest(fetchRequest: fetch)
        do{
            _ = try self.moc.execute(request)
        }catch {
            print("Failed")
        }

    }
}
