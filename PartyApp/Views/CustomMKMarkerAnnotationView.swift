//
//  MapMKAnnotationView.swift
//  PartyApp
//
//  Created by user1 on 16/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import Foundation
import MapKit
import UIKit
class CustomMKMarkerAnnotationView: MKMarkerAnnotationView{
    
    var moreInfoButton = UIButton(type: .detailDisclosure)
    var party:PartyVMProtocol?
    var delegate:PartyMapViewController?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        if let annotationPartyMapItem = annotation as? PartyMapItem {
            self.party = annotationPartyMapItem.party
            moreInfoButton.addTarget(self, action: #selector(CustomMKMarkerAnnotationView.showDetailedInformation), for: .touchDown)
            self.rightCalloutAccessoryView  = moreInfoButton
        }
        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        
        action
    }
    
    
    @objc func showDetailedInformation(){
        self.delegate?.selectedParty = self.party
        self.delegate?.performSegue(withIdentifier: StoryboardSegues.ToPartyMoreDetailsVC, sender: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(Error.notImplemented.rawValue)
    }
    
    
    
    
    
}
