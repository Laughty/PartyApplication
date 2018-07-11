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
            title.text = friendVM?.name
            friendDesc.text = friendVM?.surname
        }
    }
    
    @IBOutlet weak var imageViewContainer: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var friendDesc: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    
    
}
