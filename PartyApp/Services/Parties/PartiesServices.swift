////
////  PartiesServices.swift
////  PartyApp
////
////  Created by Piotr Rola on 11/07/2018.
////  Copyright © 2018 Piotr Rola. All rights reserved.
////
//


protocol PartiesServiceProtocol {
    func fetchAllParties() -> [Parties]
    func fetchByTitle(_ title: String) -> [Parties]
    func fetchById(_ id: Int) -> Parties?
}

class PartiesServices: AbstractService, PartiesServiceProtocol {

    
    func fetchAllParties() -> [Parties] {
        let parties: [Parties] = fetchRequest(with: nil)!
        return parties
    }
    
    func fetchByTitle(_ title: String) -> [Parties] {
        let parties: [Parties] = fetchRequest(with: Parties.makePredicateWith(title: title))!
        return parties
    }
    
    func fetchById(_ id: Int) -> Parties? {
        let parties: [Parties] = fetchRequest(with: Parties.makePredicateWith(id: id))!
        return parties.first
    }
    
    class var shared: PartiesServices {
        struct Static {
            static let instance = PartiesServices()
        }
        return Static.instance
    }
}
