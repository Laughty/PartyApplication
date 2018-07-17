//
//  FriendDetailsVC.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//


import UIKit
import CoreData

class FriendDetailsVC: UIViewController {
    
    var friend: FriendVMProtocol?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var friendImage: UIImageView!
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendTelephone: UILabel!
    @IBOutlet weak var friendEmail: UILabel!
    @IBOutlet weak var friendDescription: UILabel!
    @IBOutlet weak var friendLikes: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Friends", in: context)
        let newFriend = NSManagedObject(entity: entity!, insertInto: context) as? Friends
        
        
        newFriend?.setValue(friend?.name, forKey: "name")
        newFriend?.setValue(friend?.description, forKey: "desc")
        newFriend?.setValue(friend?.likes, forKey: "likes")
        newFriend?.email = "yolo@blabla.com"
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friends")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
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
