//
//  PartyMapViewController.swift
//  PartyApp
//
//  Created by Piotr Rola on 15/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PartyMapViewController: UIViewController  {
    
    var parties: [PartyVMProtocol] = []
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    
    var selectedParty: PartyVMProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        loadPartiesPoint()
        checkLocationAuthorizationStatus()

        // Do any additional setup after loading the view.
    }
    
    private func loadPartiesPoint(){
        for party in parties {
        let partyMapItem = PartyMapItem(party: party)
        mapView.addAnnotation(partyMapItem)
            
        }
    }
    
    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
//            centerMapOnLocation(location: CLLocation(latitude: parties.first!.location[0], longitude: parties.first!.location[1]))
            centerMapOnLocation(location: CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude ))
        } else {
//            centerMapOnLocation(location: CLLocation(latitude: parties.first!.location[0], longitude: parties.first!.location[1]))
            locationManager.requestAlwaysAuthorization()
        }
    }
    

    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = segue.identifier, selectedParty != nil {
            let destinationVC = segue.destination as! UINavigationController
            let partyMoreVC = destinationVC.viewControllers.first! as! PartyMoreDetailsVC
            
            partyMoreVC.party = selectedParty!
            partyMoreVC.isPresentedModally = true
        }
    
    }
    

}

extension PartyMapViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? PartyMapItem else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = CustomMKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            let view = view as! CustomMKMarkerAnnotationView
            view.delegate = self
            
        }
        return view
    }


    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let clickedView = view as! MKAnnotationView
        let party = view.annotation as! PartyMapItem
        centerMapOnLocation(location: CLLocation(latitude: party.coordinate.latitude, longitude: party.coordinate.longitude ))
    }
    
}


extension PartyMapViewController: CLLocationManagerDelegate {
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
           // manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
         //   manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
           // manager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }

    
}
