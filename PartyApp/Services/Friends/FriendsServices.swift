
//
//  FriendsServices.swift
//  FriendApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

protocol FriendsServiceProtocol {
    func getFriendsList(_ request: GetFriendsRequest, success: @escaping ([FriendVMProtocol]) -> (), failure: @escaping (Error?) -> ())
    func getFriend(_ request: GetFriendRequest, success: @escaping (Friend) -> (), failure: @escaping (Error?) -> ())
}

class FriendsService: AbstractService, FriendsServiceProtocol {
    func getFriendsList(_ request: GetFriendsRequest, success: @escaping ([FriendVMProtocol]) -> (), failure: @escaping (Error?) -> ()) {
        
        //        executeRequest(abstractRequest: request, requestResponse: {
        //            (response) in
        //             var friendsVMList: [FriendVMProtocol] = []
        //            switch response {
        //            case .success(let responseVal):
        //                success(friendsVMList)
        //            case .error(let err):
        //                failure(err)
        //            }
        //
        //        })
        
        Alamofire.request(BASE_URL + request.path).responseObject { (response: DataResponse<FriendList>) in
            let friends = response.result.value
            //            print("Result of downloading FriendList -> First friend's name: \(String(describing: friends.value?.friends))")
            
            var friendsVMList: [FriendVMProtocol] = []
            if friends != nil {
                for friend in friends!.friends {
                    friendsVMList.append(FriendVM(friend: friend))
                }
                success(friendsVMList)
            } else {
                failure(nil)
            }
        }
        
        
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

