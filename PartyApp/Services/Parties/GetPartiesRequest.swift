//
//  GetPartiesRequest.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class GetPartiesRequest: AbstractRequest {
    
    override init() {
        super.init()
        self.path = "getPartiesPath"
        self.method = .get
    }
    
    func getPartiesList(completion: @escaping (PartiesList?, Error?)->()) {
        Alamofire.request(path).responseObject { (response: DataResponse<PartiesList>) in
            let parties = response.result
            print("Result of downloading PartiesList -> First party's title: \(String(describing: parties.value?.parties))")
            
            switch parties {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
