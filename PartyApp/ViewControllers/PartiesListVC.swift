//
//  PartiesListViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 09/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import UIKit

// Implement as page based view controller

/*
 TODO:
 implementation
 - View Controller showing list of parties
 
 
 */

class PartiesListVC: UIPageViewController {
    
    var parties: [PartyVMProtocol] = []
    var orderedViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        
        mockData()
        dataSource = self
        
        let initialVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PartyDetailsVC") as! PartyDetailsVC
        initialVC.party = parties[0]
    
        
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PartyDetailsVC") as! PartyDetailsVC
        secondVC.party = parties[1]
        
        let thirdVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PartyDetailsVC") as! PartyDetailsVC
        thirdVC.party = parties[2]
        
        orderedViewControllers = [initialVC, secondVC, thirdVC]
        
        
      
        setViewControllers([initialVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
    
    }
    
    
    private func mockData(){
        
        for index in 1...3 {
            let party = Party(id: String(index), location: "here", time: Date(), title: "Party" + String(index), description: "Super Party", image: UIImage(named: "catParty\(index)")!)
            let partyVM = PartyVM(party: party)
            parties.append(partyVM)
            
        }
        
    }
    
    
    
}

// MARK: UIPageViewControllerDataSource

extension PartiesListVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(where: {$0 === viewController}) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(where: {$0 === viewController}) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    

    
}
