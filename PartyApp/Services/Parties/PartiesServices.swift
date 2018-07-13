//
//  PartiesServices.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


protocol PartiesServiceProtocol {
    func getPartiesList(_ request: GetPartiesRequest, success: @escaping ([PartyVMProtocol]) -> (), failure: @escaping (Error?) -> ())
    func getParty(_ request: GetPartyRequest, success: @escaping (Party) -> (), failure: @escaping (Error?) -> ())
}

class PartiesService: AbstractService, PartiesServiceProtocol {
    func getPartiesList(_ request: GetPartiesRequest, success: @escaping ([PartyVMProtocol]) -> (), failure: @escaping (Error?) -> ()) {
        
//        executeRequest(abstractRequest: request, requestResponse: {
//            (response) in
//             var partiesVMList: [PartyVMProtocol] = []
//            switch response {
//            case .success(let responseVal):
//                success(partiesVMList)
//            case .error(let err):
//                failure(err)
//            }
//            
//        })
        
        Alamofire.request(BASE_URL + request.path).responseObject { (response: DataResponse<PartiesList>) in
            let parties = response.result.value
//            print("Result of downloading PartiesList -> First party's title: \(String(describing: parties.value?.parties))")
            
            var partiesVMList: [PartyVMProtocol] = []
            if parties != nil {
            for party in parties!.parties {
                partiesVMList.append(PartyVM(party: party))
            }
                success(partiesVMList)
            } else {
                failure(nil)
            }
        }
        
        
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

