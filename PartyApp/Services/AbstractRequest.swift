//
//  AbstractRequest.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation


let BASE_URL: String = "http://funny.com"

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class AbstractRequest {
    var path: String!
    var method: HTTPMethod!
    var params: [String:String]? = nil
    var body: Any? = nil

    
    
    
}
