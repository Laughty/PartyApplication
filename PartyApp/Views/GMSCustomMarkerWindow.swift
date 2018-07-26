//
//  GMSCustomMarkerWindow.swift
//  PartyApp
//
//  Created by Rafał Małczyński on 20.07.2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit
class GMSCustomMarkerWindow: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }
    
    func setupNib() {
        Bundle.main.loadNibNamed("GMSCustomMarkerWindow", owner: self, options: nil)
        addSubview(contentView)
        contentView.addSubview(infoButton)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
