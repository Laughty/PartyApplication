//
//  PartiesServices.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import CoreData

protocol PartiesServiceProtocol {
    func getPartiesList(_ request: GetPartiesRequest, success: @escaping ([PartyVMProtocol]) -> (), failure: @escaping (Error?) -> ())
    func getParty(_ request: GetPartyRequest, success: @escaping (Party) -> (), failure: @escaping (Error?) -> ())
}

class PartiesService: AbstractService, PartiesServiceProtocol {
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
                
                CoreDataService.shared.saveDataToCoreData(name: FetchDetail.partyList, dataObject: parties)
                NotificationCenter.default.post(name: .didReceivedPartiesData, object: nil, userInfo: ["status": FetchStatus.saved])
                
            for party in parties!.parties {
                partiesVMList.append(PartyVM(party: party))
            }
                success(partiesVMList)
            } else {
                NotificationCenter.default.post(name: .didReceivedPartiesData, object: nil, userInfo: ["status": FetchStatus.failed])
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

