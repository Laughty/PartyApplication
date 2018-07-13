//
//  FriendDetailsVC.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//


import UIKit



class FriendDetailsVC: UIViewController {
    var friend: FriendVMProtocol?
    
    @IBOutlet weak var friendImage: UIImageView!
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendTelephone: UILabel!
    @IBOutlet weak var friendEmail: UILabel!
    @IBOutlet weak var friendDescription: UILabel!
    @IBOutlet weak var friendLikes: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        friendImage.image = friend?.image
        friendName.text = (friend?.name)! + " " + (friend?.surname)!
        friendDescription.text = friend?.description
        guard let likesText = friend?.likes else { return }
        friendLikes.text = "Likes: " + "\(likesText)"
        friendTelephone.text = friend?.phone
        friendEmail.text = friend?.email
    }
}
/*
 TODO:
 implementation
 - View controller for friend details
 */
