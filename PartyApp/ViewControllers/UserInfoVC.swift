//
//  UserInfoVC.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit
/*
 TODO:
 implementation
 - View controller for user details
 */

class UserInfoVC: UIViewController {
    
    var user: UserVMProtocol?
    
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("UserInfoVCTitle", comment: "")
        
        imageView.image = #imageLiteral(resourceName: "hackerman")
//        nameLabel.text = "\(user?.name ?? "") \(user?.surname ?? "")"
//        phoneLabel.text = user?.phone
//        emailLabel.text = user?.email
//        descriptionLabel.text = user?.description
        
        backgroundLabel.layer.shadowColor = UIColor.lightGray.cgColor
        backgroundLabel.layer.shadowRadius = 3.0
        backgroundLabel.layer.shadowOpacity = 1.0
        backgroundLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
}
