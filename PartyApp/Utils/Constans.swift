//
//  Constans.swift
//  PartyApp
//
//  Created by Piotr Rola on 11/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation

enum ConfigurationSrings: String{
    case apiURL = "http://demo9453650.mockable.io/appInitialData"
}

enum StoryboardIds: String {
    case main = "Main"
}

enum PartiesVCIds: String {
    case partyList = "PartiesListVC"
    case partyDetails = "PartyDetailsVC"
    case noParties = "NoPartiesVC"
    case partyMoreDetails = "PartyMoreDetailsVC"
}

enum Error: String {
    case notImplemented = "has not been implemented"
    case notFindPartyDetail = "Not able to find PartyDetailVC in Main storyboard"
}

struct StoryboardSegues {
    static let ToPartyList = "toPartyListVC"
    static let ToFriendsList = "toFriendsListVC"
    static let ToProfile = "toProfileVC"
    static let ToFriendDetails = "toFriendDetailsVC"
    static let ToPartyMoreDetailsVC = "toPartyMoreDetailsVC"
    static let ToPartyListVCFromNotification = "toPartyListVCFromNotification"
}
