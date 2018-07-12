//
//  AbstractService.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error?)
}

protocol AbstractServiceProtocol {
    func executeRequest(abstractRequest: AbstractRequest) -> Result<Any>
}

class AbstractService: AbstractServiceProtocol {
    
    func executeRequest(abstractRequest: AbstractRequest) -> Result<Any> {
        
        return Result.success("")
    }
    
}
