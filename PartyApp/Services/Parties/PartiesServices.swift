//
//  PartiesServices.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation


protocol PartiesServiceProtocol {
    func getPartiesList(_ request: GetPartiesRequest, success: ([Party]) -> (), failure: (Error?) -> ())
    func getParty(_ request: GetPartiesRequest, success: (Party) -> (), failure: (Error?) -> ())
}

class PartiesService: AbstractService, PartiesServiceProtocol {
    
    class var shared: PartiesService {
        struct Static {
            static let instance = PartiesService()
        }
        return Static.instance
    }

    
    func getParty(_ request: GetPartiesRequest, success: (Party) -> (), failure: (Error?) -> ()) {
        switch executeRequest(abstractRequest: request) {
        case .success(let responseVal):
            success(responseVal as! Party)
        case .error(let err):
            failure(err)
        }
    }
    
    
    func getPartiesList(_ request: GetPartiesRequest, success: ([Party]) -> (), failure: (Error?) -> ()) {
        
    }
    
}

