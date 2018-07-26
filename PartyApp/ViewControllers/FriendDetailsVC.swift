//
//  FriendDetailsVC.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//


import UIKit
//import CoreData

class FriendDetailsVC: UIViewController {
    
    var friend: FriendVMProtocol?
    
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet weak var friendImage: UIImageView!
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendTelephone: UILabel!
    @IBOutlet weak var friendEmail: UILabel!
    @IBOutlet weak var friendDescription: UILabel!
    @IBOutlet weak var friendLikes: UILabel!
    @IBOutlet weak var friendBackground: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("FriendDetailsVCTitle", comment: "")
        
        friendImage.image = friend?.image
        friendName.text = (friend?.name)! + " " + (friend?.surname)!
        friendDescription.text = friend?.description
        guard let likesText = friend?.likes else { return }
        friendLikes.text = "Likes: \(likesText)"
        friendTelephone.text = friend?.phone
        friendEmail.text = friend?.email
        
        friendBackground.layer.shadowColor = UIColor.lightGray.cgColor
        friendBackground.layer.shadowRadius = 3.0
        friendBackground.layer.shadowOpacity = 1.0
        friendBackground.layer.shadowOffset = CGSize(width: 4, height: 4)
//        friendBackground.layer.borderColor = UIColor.lightGray.cgColor
//        friendBackground.layer.borderWidth = 1.0;
        
    }
    
    
    
}
/*
 TODO:
 implementation
 - View controller for friend details
 */
