//
//  PartyDetailsVC.swift
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
 - View controller for party details
 */

class PartyDetailsVC: UIViewController {
    
    var party: PartyVMProtocol?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var partyTitle: UILabel!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        if let party = party {
            image.image = party.image
            partyTitle.text = party.title
        }
    }
    
    
        
    }
    
    

    
    

