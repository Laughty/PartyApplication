//
//  PartyMapItem.swift
//  PartyApp
//
//  Created by Piotr Rola on 15/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import MapKit

class PartyMapItem: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    let party: PartyVMProtocol
    
    init(party: PartyVMProtocol) {
        self.party = party
        self.coordinate = CLLocationCoordinate2D(latitude: party.latitude, longitude: party.longitude)
        super.init()
    }
    
    var title: String? {
        return party.title
    }
}
