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
    func executeRequest(abstractRequest: AbstractRequest, requestResponse: @escaping (Result<Any>) -> ())
    
    //class func fetchRequest<T: NSManagedObject>(with predicate: NSPredicate?) -> [T]?
}

class AbstractService: AbstractServiceProtocol {
    
    class func fetchRequest<T>(with predicate: NSPredicate?) -> [T]? where T: NSManagedObject {
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entity().name!)
        
        do {
            request.predicate = predicate
            let requestResult = try moc.fetch(request) as? [T]
            print(requestResult)
            return requestResult
        } catch {
            print("Couldn't find proper entity")
            return nil
        }
    }
    
    
    func executeRequest(abstractRequest: AbstractRequest, requestResponse: @escaping (Result<Any>) -> ()) {
        let url = BASE_URL + abstractRequest.path
        
        Alamofire.request(url, method: abstractRequest.method).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                return requestResponse(Result.success(json))
            }
        }
    }
    
    class var shared: AbstractService {
        struct Static {
            static let instance = AbstractService()
        }
        return Static.instance
    }
}


//            Alamofire.request(BASE_URL + request.path).responseObject { (response: DataResponse<PartiesList>) in
//                let parties = response.result.value
//                //            print("Result of downloading PartiesList -> First party's title: \(String(describing: parties.value?.parties))")
//
//                var partiesVMList: [PartyVMProtocol] = []
//                if parties != nil {
//                    for party in parties!.parties {
//                        partiesVMList.append(PartyVM(party: party))
//                    }
//                    success(partiesVMList)
//                } else {
//                    failure(nil)
//                }
//            }

