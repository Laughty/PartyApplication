//
//  PartiesServices.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation


protocol PartiesServiceProtocol {
    func getPartiesList(_ request: GetPartiesRequest, success: @escaping ([PartyVMProtocol]) -> (), failure: @escaping (Error?) -> ())
    func getParty(_ request: GetPartyRequest, success: @escaping (Party) -> (), failure: @escaping (Error?) -> ())
}

class PartiesService: AbstractService, PartiesServiceProtocol {
    func getPartiesList(_ request: GetPartiesRequest, success: @escaping ([PartyVMProtocol]) -> (), failure: @escaping (Error?) -> ()) {
        
    }
    
    func getParty(_ request: GetPartyRequest, success: @escaping (Party) -> (), failure: @escaping (Error?) -> ()) {
        executeRequest(abstractRequest: request, requestResponse: { (response) in
            switch response {
            case .success(let responseVal):
                success(responseVal as! Party)
            case .error(let err):
                failure(err)
            }
        })
    }
    

    
    class var shared: PartiesService {
        struct Static {
            static let instance = PartiesService()
        }
        return Static.instance
    }

    

    
}

