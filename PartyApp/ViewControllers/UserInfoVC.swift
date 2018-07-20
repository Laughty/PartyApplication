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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("UserInfoVCTitle", comment: "")
        
        imageView.image = user?.image
        nameLabel.text = "\(user?.name) \(user?.surname)"
        phoneLabel.text = user?.phone
        emailLabel.text = user?.email
        descriptionLabel.text = user?.description
    }
    
}
