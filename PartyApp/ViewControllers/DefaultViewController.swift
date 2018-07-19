//
//  DefaultViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 13/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController {
    
    let loadingView: LoadingView = UIView.fromNib()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.hide()
        view.addSubview(loadingView)
        

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

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
