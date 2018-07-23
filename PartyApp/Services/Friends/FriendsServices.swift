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



class FriendsSevices: AbstractService {
    
    
    func fetchAllFriends() -> [Friends]{
        let friends: [Friends] = fetchRequest(with: Friends.fetchRequestBy(id: <#T##Int#>))
        return friends
    }
    
}
