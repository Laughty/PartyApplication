//
//  WelcomeViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension Notification.Name {
    static let didReceivedPartiesData = Notification.Name("didReceiveDataParty")
}

enum FetchStatus {
    case saved
    case inprogress
    case failed
    case notStarted
}

class WelcomeVC: DefaultViewController, UITextFieldDelegate {
    
    @IBOutlet weak var welcomeImage: UIImageView!
    
    var partiesDataStatus: FetchStatus = .notStarted
    
    //could be used
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var parties: [PartyVMProtocol] = []
    var friends: [FriendVMProtocol] = []
    var user: UserVMProtocol? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.frame=self.view.frame
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceivedPartiesData, object: nil)
    
        GhettoDataLoad() //To CoreData Service
        
        //####    COREDATA ######
        

    }
    
    
    @IBAction func toPartyListButtonTapped(_ sender: UIButton) {
        
        //REDO
        self.performSegue(withIdentifier: StoryboardSegues.ToPartyList, sender: self) //TODLETE
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .didReceivedPartiesData, object: nil)
    }
    
    @objc func fetchDataStatusUpdate(_ notification:Notification) {
        notification.userInfo
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
     //   notification.userInfo?["status"]
        
        //performSegue(withIdentifier: StoryboardSegues.ToPartyList, sender: self) //WHAT
    }
    
    
    @IBAction func toFriendListButtonTapped(_ sender: UIButton) {
        
        //REDO
        self.performSegue(withIdentifier: StoryboardSegues.ToFriendsList, sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
        switch segueId {
        case StoryboardSegues.ToPartyList:
            let destinationVC = segue.destination as! UITabBarController
            let partiesListVC = destinationVC.viewControllers?.first! as! PartiesListVC
            partiesListVC.parties = parties
            let partyMapVC = destinationVC.viewControllers?[1] as! PartyMapViewController
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
    
    func GhettoDataLoad(){ //Ghetto function -> to CoreData services
        
        //GhettoLoad Parties
        self.loadingView.show()
        let requestP = GetPartiesRequest()
        partiesDataStatus = .inprogress
        PartiesService.shared.getPartiesList(requestP, success: {[weak self] (parties) in
            self?.parties = parties
            self?.loadingView.hide()
            NotificationCenter.default.post(name: .didReceivedPartiesData, object: nil)
        }){[weak self] (error) in
            self?.loadingView.hide()
            print(error ?? "Something went wrong")
        }
        
        //GhettoLoad Friends
        loadingView.show()
        let requestF = GetFriendsRequest()
        FriendsService.shared.getFriendsList(requestF, success: { [weak self] (friends) in
            self?.friends = friends
            self?.loadingView.hide()
        }){[weak self] (error) in
            self?.loadingView.hide()
            print(error ?? "Something went wrong")
        }
        
        //GhettoCoreData
        
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
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        //        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .allowAnimatedContent, animations: {
//        //            self.welcomeImage.center = CGPoint(x: self.welcomeImage.center.x, y: self.welcomeImage.center.y + 300)
//        //
//        //        }, completion: { _ in
//        //            UIView.animate(withDuration: 1, animations: {
//        //                         self.welcomeImage.center = CGPoint(x: self.welcomeImage.center.x, y: self.welcomeImage.center.y - 300)
//        //            })
//        //
//        //        })
    
        
}

    

