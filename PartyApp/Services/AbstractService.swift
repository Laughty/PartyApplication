//
//  AbstractService.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Alamofire
import CoreData

fileprivate extension NSManagedObject {
    class func entityName() -> String {
        let fullClassName = NSStringFromClass(object_getClass(self))
        let nameComponents = split(fullClassName) { $0 == "." }
        return last(nameComponents)!
    }
}

enum Result<T> {
    case success(T)
    case error(Error?)
}

protocol AbstractServiceProtocol {
    func executeRequest(abstractRequest: AbstractRequest, requestResponse: @escaping (Result<Any>) -> ())
    
    func ferchRequestBy<T: NSManagedObject>(with predicate: NSPredicate?) -> T?
}

class AbstractService: AbstractServiceProtocol {
    
    func ferchRequestBy<T>(with predicate: NSPredicate?) -> T? where T : NSManagedObject {
        let request = NSFetchRequest<T>(entityName: T.entityName())
        
        if let predicate = predicate {
            request.predicate = predicate
            request.returnsObjectsAsFaults = false
            return request
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
            
        }
        
    }
    
}
