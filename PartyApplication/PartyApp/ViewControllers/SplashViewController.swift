//
//  SplashViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    let animatedULogoView = UIImageView(frame: CGRect(x: 16, y: 50, width: 343, height: 419))
    
    public init(tileViewFileName: String) {

        super.init(nibName: nil, bundle: nil)
        let image = UIImage.animatedImage(with: [UIImage(named: "catParty1")!, UIImage(named: "catParty2")!, UIImage(named: "catParty3")!], duration: 0.2)
        animatedULogoView.image = image
        view.addSubview(animatedULogoView)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var prefersStatusBarHidden : Bool {
        return true
    }


}

