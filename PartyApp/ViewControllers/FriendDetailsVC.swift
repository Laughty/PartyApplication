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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Piotrek zostawił śmieci :/ UITest wyłapał :-)
        //let entity = NSEntityDescription.entity(forEntityName: "Friends", in: moc)
        //let newFriend = NSManagedObject(entity: entity!, insertInto: moc) as? Friends
        //let nextFriend = Friends(entity: entity!, insertInto: moc)
        
        
//        newFriend?.setValue(friend?.name, forKey: "name")
//        newFriend?.setValue(friend?.description, forKey: "desc")
//        newFriend?.setValue(friend?.likes, forKey: "likes")
//        newFriend?.email = "yolo@blabla.com"
//
//
//        do {
//            try moc.save()
//        } catch {
//            print("Failed saving")
//        }
        
        findFriendByName(name: (friend?.name)!)
        friendImage.image = friend?.image
        friendName.text = (friend?.name)! + " " + (friend?.surname)!
        friendDescription.text = friend?.description
        guard let likesText = friend?.likes else { return }
        friendLikes.text = "Likes: \(likesText)"
        friendTelephone.text = friend?.phone
        friendEmail.text = friend?.email
    }
    
    
    
    func findFriendByName(name: String){
        //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friends")
      //  request.predicate = NSPredicate(format: "age = %@ ", "12")
      //  request.returnsObjectsAsFaults = false
        
        do {
            let result = try moc.fetch(Friends.fetchRequest())
            for data in result as! [Friends] {
                print(data.name)
                print(data.email)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
}
/*
 TODO:
 implementation
 - View controller for friend details
 */
