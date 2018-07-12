//
//  GetFriendsRequest.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation


class GetFriendsRequest: AbstractRequest{
    
    override init (){
        
        super.init()
        self.method = .get
        self.path = "getFriendsPath"
        
    }
    
}
