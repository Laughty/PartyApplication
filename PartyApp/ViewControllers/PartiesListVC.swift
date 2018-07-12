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
    
    let DEFAULT_CELL_HEIGHT = 100
    
    
    var parties: [PartyVMProtocol] = []
    var orderedViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
    }
    
    private func configurePageViewController(){
        prepareViewControllers()
        dataSource = self
        if let initialVC = orderedViewControllers.first {
            setViewControllers([initialVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            if parties.isEmpty {
                view.isUserInteractionEnabled = false
            }
        } else {
            
            // Empty state behavior
            
        }
    }
    
    private func prepareViewControllers(){
        if parties.isEmpty {
            let noPartiesVC = UIStoryboard(name: StoryboardIds.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: PartiesVCIds.noParties.rawValue)
            orderedViewControllers.append(noPartiesVC)
        } else {
            for party in parties {
                orderedViewControllers.append(initPartyVC(withParty: party))
            }
        }
    }
    
    private func initPartyVC(withParty party: PartyVMProtocol) -> PartyDetailsVC{
        
        if let vc = UIStoryboard(name: StoryboardIds.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: PartiesVCIds.partyDetails.rawValue) as? PartyDetailsVC {
            vc.party = party
            return vc
        } else {
            
            fatalError("Not able to find PartyDetailVC in Main storyboard")
        }
        
    }
    
    private func loadViewControllers() {
        
    }
    
    
    
}

// MARK: UIPageViewControllerDataSource

extension PartiesListVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
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
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
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
