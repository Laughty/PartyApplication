//
//  GetPartiesRequest.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation


class GetPartiesRequest: AbstractRequest {
    
    override init() {
        super.init()
        self.path = "getPartiesPath"
        self.method = .get
    }
    
}
