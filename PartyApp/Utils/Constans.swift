//
//  Constans.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation


enum StoryboardIds: String {
    case main = "Main"
}

enum PartiesVCIds: String {
    case partyList = "PartiesListVC"
    case partyDetails = "PartyDetailsVC"
    case noParties = "NoPartiesVC"
    case partyMoreDetails = "PartyMoreDetailsVC"
}

struct StoryboardSegues {
    static let ToPartyList = "toPartyListVC"
    static let ToFriendsList = "toFriendsListVC"
    static let ToProfile = "toProfileVC"
    static let ToFriendDetails = "toFriendDetailsVC"
    static let ToPartyMoreDetailsVC = "toPartyMoreDetailsVC"
}
