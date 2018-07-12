//
//  PartyMoreDetails.swift
//  PartyApp
//
//  Created by user1 on 12.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit

class PartyMoreDetails: UIViewController {

    var party: PartyVMProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let party = party {
            //image.image = party.image
            //partyTitle.text = party.title
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

