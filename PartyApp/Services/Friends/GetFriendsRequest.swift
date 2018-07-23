////
////  GetFriendsRequest.swift
////  PartyApp
////
////  Created by Piotr Rola on 11/07/2018.
////  Copyright © 2018 Piotr Rola. All rights reserved.
////
//
//import AlamofireObjectMapper
//import Alamofire
//
//class GetFriendsRequest: AbstractRequest {
//    
//    override init() {
//        super.init()
//        self.path = "friends"
//        self.method = .get
//    }
//    
//    func getFriendsList(completion: @escaping (FriendList?, Error?)->()) {
//        Alamofire.request(BASE_URL + path).responseObject { (response: DataResponse<FriendList>) in
//            let friends = response.result
//            print("Result of downloading FriendList -> First friend's name: \(String(describing: friends.value?.friends))")
//            
//            switch friends {
//            case .success(let value):
//                completion(value, nil)
//            case .failure(let error):
//                completion(nil, error as? Error)
//            }
//        }
//    }
//}
