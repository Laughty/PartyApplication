//
//  AlamofireService.swift
//  PartyApp
//
//  Created by user1 on 19.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import Alamofire
import CoreData
import AlamofireCoreData

class InitService {
    
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    class var shared: InitService {
        struct Static {
            static let instance = InitService()
        }
        return Static.instance
    }
    
    func getInitData(_ urlAdress: String) -> () {
        cleanRecordForEntity()
       Alamofire.request(URL(string:urlAdress)!).responseInsert(context: moc, type:InitialData.self ) { response in
                switch response.result {
                case let .success(response):
                     UserDefaults.standard.set(true, forKey: "IsDataInitialized")
                case .failure:
                    print("Can't map init request")
        }
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
            UserDefaults.standard.set(false, forKey: "IsDataInitialized")

        }catch {
            print("Failed")
        }

    }
}
