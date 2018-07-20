//
//  PartyMoreDetails.swift
//  PartyApp
//
//  Created by user1 on 12.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit

class PartyMoreDetailsVC: UIViewController {

    var party: PartyVMProtocol?
    
    @IBOutlet weak var partyImage: UIImageView!
    @IBOutlet weak var partyTitle: UILabel!
    @IBOutlet weak var partyTime: UILabel!
    @IBOutlet weak var partyLocation: UILabel!
    @IBOutlet weak var partyDescription: UILabel!
    
    var isPresentedModally = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("PartyMoreDetailsVCTitle", comment: "")
        
        if let party = party {
            partyImage.image = party.image
            partyTitle.text = party.title
            partyLocation.text = "long: \(party.longitude) lati: \(party.latitude)"
            partyDescription.text = party.description
            partyTime.text = party.time.toString()
        }
        
        if isPresentedModally {
           navigationController?.navigationBar.backItem?.hidesBackButton = false
            let leftButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissFromModal))
            self.navigationItem.leftBarButtonItem = leftButton
            let gesture = UITapGestureRecognizer(target: self, action: #selector(PartyMoreDetailsVC.dismissFromModal))
            view.addGestureRecognizer(gesture)
            
        }
        
    }
    
    @objc func dismissFromModal(){
        navigationController?.dismiss(animated: true, completion: nil)
        
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

