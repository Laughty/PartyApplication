//
//  FriendsServices.swift
//  FriendApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//
import Foundation

protocol FriendsServiceProtocol {
    func fetchAllFriends() -> [Friends]
    func fetchByName(_ name: String) -> [Friends]
    func fetchById(_ id: Int) -> Friends?
}

class FriendsServices: AbstractService, FriendsServiceProtocol {
    func fetchAllFriends() -> [Friends] {
        let friends: [Friends] = fetchRequest(with: nil)!
        return friends
    }
    
    func fetchByName(_ name: String) -> [Friends] {
//        let friend: [Friends] = fetchRequest(with: Friends.FriendsPredicateFactory.name(name).predicate)!
        let friend: [Friends] = fetchRequest(with: Friends.FriendsPredicateFactory.name(name))!
        return friend
    }
    
    func fetchById(_ id: Int) -> Friends? {
        let friend: [Friends] = fetchRequest(with: Friends.makePredicateWith(id: id))!
        return friend.first
    }
    
    class var shared: FriendsServices {
        struct Static {
            static let instance = FriendsServices()
        }
        return Static.instance
    }
}
