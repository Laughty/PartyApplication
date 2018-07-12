//
//  GetFriendRequest.swift
//  FriendApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

class GetFriendRequest: AbstractRequest {
    
    var friendId: String {
        didSet {
            params = ["friendId" : friendId]
        }
    }
    
    override init() {
        friendId = ""
        super.init()
        self.path = "getFriendsPath"
        self.method = .get
    }
    
}
