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
import CoreData

class PartyMapViewController: UIViewController  {
    
    var parties: [PartyVMProtocol] = []
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 6000
    let startLat = 52.229983
    let startLong = 21.00193
    
    var selectedParty: PartyVMProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title=NSLocalizedString("PartyMapVCTitle", comment: "")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        loadPartiesPoint()
        checkLocationAuthorizationStatus()
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(startLat, startLong), regionRadius, regionRadius), animated: true)
        
        mapView.showsUserLocation=true
        
        //mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        
        print(mapView.userLocation.coordinate)

        // Do any additional setup after loading the view.
    }
    
    private func loadPartiesPoint(){
        fetchPartiesData()
        for party in parties {
        let partyMapItem = PartyMapItem(party: party)
        mapView.addAnnotation(partyMapItem)
            
        }
    }
    func fetchPartiesData() {
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Parties")
        request.returnsObjectsAsFaults = false
        do {
            let partyObjects = try moc.fetch(request) as! [Parties]
            for party in partyObjects {
                parties.append(PartyVM(party: party))
                //print(party)
            }
        } catch{
            print("Failed")
        }
    }
    
    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
//            centerMapOnLocation(location: CLLocation(latitude: parties.first!.location[0], longitude: parties.first!.location[1]))
            //print(mapView.userLocation.coordinate)
            //centerMapOnLocation(location: CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude ))
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



    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //mapView.setCenter(userLocation.coordinate, animated: true)
        mapView.setCenter(userLocation.coordinate, animated: true)
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
