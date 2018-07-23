//
//  FriendCellItem.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit

class FriendCellItem: UITableViewCell {
    
    static let CellReusableIdentifier = "FriendCellItem"
    var friendVM: FriendVMProtocol? {
        didSet {
            imageViewContainer.image = friendVM?.image
            guard let nameText = friendVM?.name, let surnameText = friendVM?.surname else { return }
            title.text = "\(nameText) \(surnameText)"
            guard let descText = friendVM?.description else { return }
            desc.text = descText
        }
    }
    
    @IBOutlet weak var imageViewContainer: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    
    
}
