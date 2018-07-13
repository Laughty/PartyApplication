//
//  AbstractRequest.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import Alamofire


let BASE_URL: String = "http://demo9453650.mockable.io/"


class AbstractRequest {
    var path: String!
    var responseType: AnyClass!
    var method: HTTPMethod!
    var params: [String:String]? = nil
    var body: Any? = nil

    
    
    
}
