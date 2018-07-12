//
//  AbstractService.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case error(Error?)
}

protocol AbstractServiceProtocol {
    func executeRequest(abstractRequest: AbstractRequest, requestResponse: @escaping (Result<Any>) -> ())
}

class AbstractService: AbstractServiceProtocol {
    
    func executeRequest(abstractRequest: AbstractRequest, requestResponse: @escaping (Result<Any>) -> ()) {
        let url = BASE_URL + abstractRequest.path
        
        Alamofire.request("https://httpbin.org/get", method: abstractRequest.method).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                return requestResponse(Result.success(json))
            }
            
        }
        
    }
    
}
