//
//  WelcomeViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit

class WelcomeVC: UIViewController, UITextFieldDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
        switch segueId {
        case StoryboardSegues.ToPartyList:
            let destinationVC = segue.destination as! PartiesListVC
            let random = arc4random_uniform(2)
            print(random)
            if random == 0 {
                destinationVC.parties = mockDataParties()
            }
        case StoryboardSegues.ToFriendsList:
            let destinationVC = segue.destination as! FriendsListVC
            destinationVC.friends = mockDataFriends()
        default:
            fatalError("Unknow segue")
        }
        
        }
    }
    
    
    private func mockDataParties() -> [PartyVMProtocol]{
        var parties: [PartyVMProtocol] = []
        for index in 1...3 {
            let party = Party(id: String(index), location: "here", time: Date(), title: "Party" + String(index), description: "Super Party", image: UIImage(named: "catParty\(index)")!)
            let partyVM = PartyVM(party: party)
            parties.append(partyVM)
            
        }
        return parties
        
    }
    
    private func mockDataFriends() -> [FriendVMProtocol]{
        var friends: [FriendVMProtocol] = []
        for index in 1...3 {
            let friend = Friend(id: String(index), name: "Bob\(index)", surname: "Bobsky", likes: index, description: "funny", photo: UIImage(named: "catParty\(index)")!, phone: "1111", email: "abc@abc.pl")
            let friendVM = FriendVM(friend: friend)
            friends.append(friendVM)
            
        }
        return friends
    }

    
    
}
