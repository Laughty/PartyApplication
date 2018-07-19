//
//  SplashViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {


    
    public init(tileViewFileName: String) {

        super.init(nibName: nil, bundle: nil)
        let animatedULogoView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: 281))
        animatedULogoView.center = view.center
        var images: [UIImage] = []
        for index in 1...12 {
            images.append(UIImage(named: "intro\(index)")!)
        }
        let image = UIImage.animatedImage(with: images, duration: 1)
        animatedULogoView.image = image
        view.addSubview(animatedULogoView)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError(Error.notImplemented.rawValue)
    }
    
    open override var prefersStatusBarHidden : Bool {
        return true
    }


}

