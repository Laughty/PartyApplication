//
//  WelcomeViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit

class WelcomeVC: DefaultViewController, UITextFieldDelegate {

    let blaaa = ""
    
    @IBOutlet weak var welcomeImage: UIImageView!
    var parties: [PartyVMProtocol] = []
    
    
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.frame=self.view.frame

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .allowAnimatedContent, animations: {
//            self.welcomeImage.center = CGPoint(x: self.welcomeImage.center.x, y: self.welcomeImage.center.y + 300)
//
//        }, completion: { _ in
//            UIView.animate(withDuration: 1, animations: {
//                         self.welcomeImage.center = CGPoint(x: self.welcomeImage.center.x, y: self.welcomeImage.center.y - 300)
//            })
//
//        })
        
        
    }
    
    @IBAction func toPartyListButtonTapped(_ sender: UIButton) {
        
        loadingView.show()
        
        let request = GetPartiesRequest()
        PartiesService.shared.getPartiesList(request, success: {[weak self] (parties) in
            self?.parties = parties
            self?.performSegue(withIdentifier: StoryboardSegues.ToPartyList, sender: self)
            self?.loadingView.hide()
        }){[weak self] (error) in
            self?.loadingView.hide()
            print(error ?? "Something went wrong")
        }
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
        switch segueId {
        case StoryboardSegues.ToPartyList:
            let destinationVC = segue.destination as! PartiesListVC
            destinationVC.parties = parties
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
            let party = Party(id: String(index), location: "here", time: Date(), title: "Party" + String(index), description: "Super Party", image: "catParty\(index)")
            let partyVM = PartyVM(party: party)
            parties.append(partyVM)
            
        }
        return parties
        
    }
    
    private func mockDataFriends() -> [FriendVMProtocol]{
        
        var friends: [FriendVMProtocol] = []
        for index in 1...3 {
            let friend = Friend(id: String(index), name: "Bob\(index)", surname: "Bobsky", likes: index, description: "funny", photo: "catParty\(index)", phone: "1111", email: "abc@abc.pl")
            let friendVM = FriendVM(friend: friend)
            friends.append(friendVM)
            
        }
        return friends
    }

    
    
}
