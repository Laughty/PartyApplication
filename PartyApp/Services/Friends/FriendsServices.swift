
//
//  FriendsServices.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation


protocol FriendsServiceProtocol {
    func getFriendsList(_ request: GetFriendsRequest, success: @escaping ([FriendVMProtocol]) -> (), failure: @escaping (Error?) -> ())
    func getFriend(_ request: GetFriendRequest, success: @escaping (Friend) -> (), failure: @escaping (Error?) -> ())
}

class FriendsService: AbstractService, FriendsServiceProtocol {
    func getFriendsList(_ request: GetFriendsRequest, success: @escaping ([FriendVMProtocol]) -> (), failure: @escaping (Error?) -> ()) {
    }
    
    func getFriend(_ request: GetFriendRequest, success: @escaping (Friend) -> (), failure: @escaping (Error?) -> ()) {
        executeRequest(abstractRequest: request, requestResponse: { (response) in
            switch response {
            case .success(let responseVal):
                success(responseVal as! Friend)
            case .error(let err):
                failure(err)
            }
        })
    }
    
    
    
    class var shared: FriendsService {
        struct Static {
            static let instance = FriendsService()
        }
        return Static.instance
    }
    
    
    
    
}

