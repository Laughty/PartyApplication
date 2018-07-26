
//
//  PartyDetailsVC.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

/*
 TODO:
 implementation
 - View controller for party details
 */

class PartyDetailsVC: UIViewController {
    
    var party: PartyVMProtocol?
    
    @IBOutlet weak var detailButton: MDCButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var partyTitle: UILabel!
    @IBOutlet weak var backgroundLabel: UILabel!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("PartyDetailsVCTitle", comment: "")
        
        backgroundLabel.layer.shadowColor = UIColor.lightGray.cgColor
        backgroundLabel.layer.shadowRadius = 3.0
        backgroundLabel.layer.shadowOpacity = 1.0
        backgroundLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        detailButton.layer.cornerRadius = 0.5 * detailButton.bounds.size.width
        
        if let party = party {
            image.image = party.image
            partyTitle.text = party.title
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationItem.title=NSLocalizedString("PartyDetailsVCTitle", comment: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            let destinationVC = segue.destination as! PartyMoreDetailsVC
            destinationVC.party = party
        }
    
    
        
    }
    
}

