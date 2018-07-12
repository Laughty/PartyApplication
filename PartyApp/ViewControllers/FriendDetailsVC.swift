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
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        friendImage.image = friend?.image
        friendName.text = friend?.name
    }
}
/*
 TODO:
 implementation
 - View controller for friend details
 */
