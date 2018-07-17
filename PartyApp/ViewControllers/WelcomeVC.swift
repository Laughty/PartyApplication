//
//  WelcomeViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    static let didReceivedPartiesData = Notification.Name("didReceiveDataParty")
}

class WelcomeVC: DefaultViewController, UITextFieldDelegate {
    
    @IBOutlet weak var welcomeImage: UIImageView!
    var parties: [PartyVMProtocol] = []
    var friends: [FriendVMProtocol] = []
    var user: UserVMProtocol? = nil
    
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.frame=self.view.frame
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceivedPartiesData, object: nil)

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
            self?.loadingView.hide()
            NotificationCenter.default.post(name: .didReceivedPartiesData, object: nil)
        }){[weak self] (error) in
            self?.loadingView.hide()
            print(error ?? "Something went wrong")
        }
        
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        performSegue(withIdentifier: StoryboardSegues.ToPartyList, sender: self)
    }
    
    
    @IBAction func toFriendListButtonTapped(_ sender: UIButton) {
        
        loadingView.show()
        
        let request = GetFriendsRequest()
        FriendsService.shared.getFriendsList(request, success: { [weak self] (friends) in
            self?.friends = friends
            self?.performSegue(withIdentifier: StoryboardSegues.ToFriendsList, sender: self)
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
            let destinationVC = segue.destination as! UITabBarController
            let partiesListVC = destinationVC.viewControllers?.first! as! PartiesListVC
            partiesListVC.parties = parties
            let partyMapVC = destinationVC.viewControllers?.last! as! PartyMapViewController
            partyMapVC.parties = parties
        case StoryboardSegues.ToFriendsList:
            let destinationVC = segue.destination as! FriendsListVC
            destinationVC.friends = friends
        case StoryboardSegues.ToProfile:
            let destinationVC = segue.destination as! UserInfoVC
            if let user = user {
                destinationVC.user = user
            }
        default:
            fatalError("Unknow segue")
        }
        }
    }
    
    
//    private func mockDataParties() -> [PartyVMProtocol]{
//        var parties: [PartyVMProtocol] = []
//        for index in 1...3 {
//            let party = Party(id: String(index), location: "here", time: Date(), title: "Party" + String(index), description: "Super Party", image: "catParty\(index)")
//            let partyVM = PartyVM(party: party)
//            parties.append(partyVM)
//
//        }
//        return parties
//
//    }
//
//    private func mockDataFriends() -> [FriendVMProtocol]{
//
//        var friends: [FriendVMProtocol] = []
//        for index in 1...3 {
//            let friend = Friend(id: String(index), name: "Bob\(index)", surname: "Bobsky", likes: index, description: "funny", photo: "catParty\(index)", phone: "1111", email: "abc@abc.pl")
//            let friendVM = FriendVM(friend: friend)
//            friends.append(friendVM)
//
//        }
//        return friends
//    }

    
    
}
