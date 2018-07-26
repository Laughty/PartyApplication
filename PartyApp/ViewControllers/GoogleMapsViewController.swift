//
//  GoogleMapsViewController.swift
//  PartyApp
//
//  Created by user1 on 17/07/2018.
//  Copyright © 2018 Piotr Rola. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import CoreData

class GoogleMapsViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var googleMaps: GMSMapView!
    
    var locationManager = CLLocationManager()
    var locationStart = CLLocation()
    var locationStop = CLLocation()
    
    var parties: [PartyVMProtocol] = []
    var selectedParty: PartyVMProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPartiesData()
        setupController()
        makeItDark()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.title=NSLocalizedString("GoogleMapsVCTitle", comment: "")
        self.googleMaps.clear()
        self.loadCameraLocation()
        self.loadMapConfiguration()
        createMarkersFrom(parties)
        
    }
    
    func loadMapConfiguration(){
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
    }
    
    func loadCameraLocation(){
        if selectedParty != nil {
            locationStart = CLLocation(latitude: selectedParty!.latitude, longitude: selectedParty!.longitude)
        } else if locationManager.location != nil {
            locationStart = locationManager.location!
        }
        self.googleMaps.camera = GMSCameraPosition(target: locationStart.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    }
    
    
    // MARK: Setup the View Controller
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
    
    func setupController() {
        googleMaps.delegate = self
        checkLocationAuthorizationStatus()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    private func makeItDark(){
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "gmaps_style", withExtension: "json") {
                googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }

    // MARK: Creating markers
    func createMarkersFrom(_ parties: [PartyVMProtocol]) {
        for party in parties {
            createMarker(title: party.title,
                         with: CLLocation(latitude: party.latitude, longitude: party.longitude),
                         from: party)
        }
    }
    
    func createMarker(title: String, with location: CLLocation, from party: PartyVMProtocol){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: party.latitude, longitude: party.longitude)
        marker.title = title
        marker.snippet = "Tap for details"
        marker.map = googleMaps
    }
    
    // - MARK: Drawing paths
    func drawPatch(startLocation:CLLocation, stopLocation:CLLocation){
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(stopLocation.coordinate.latitude),\(stopLocation.coordinate.longitude)"
    
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyC6AZgUwTCF97I-4FqEeBZkKgXFeR3NnGA"
        
        Alamofire.request(url).responseJSON{ response in
                if let json = response.result.value {
                    // TODO: tak też można ale ogólnie mamy do tego JSON serialize
                    let dictonary = json as! NSDictionary
                    let routes = dictonary["routes"] as! [NSDictionary]
                    for route in routes{
                        let routeOverviewPolyline = route["overview_polyline"] as! NSDictionary
                        let points = routeOverviewPolyline["points"] as! String
                        let path = GMSPath.init(fromEncodedPath: points)
                        let polyline = GMSPolyline.init(path: path)
                        polyline.strokeWidth = 4
                        polyline.strokeColor = UIColor.red
                        polyline.map = self.googleMaps
                        
                    }
                }
        }
    }
    
    // - MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case StoryboardSegues.ToPartyMoreDetailsVC:
            let destinationVC = segue.destination as! PartyMoreDetailsVC
            if selectedParty != nil {
                destinationVC.party = selectedParty
            }
        default:
            print("Default case, no segue found")
        }
    }
}

// - MARK: GoogleMapsViewControllerDelegate methods
extension GoogleMapsViewController {
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = GMSCustomMarkerWindow(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 50)))
        
        for party in parties {
            if marker.position.latitude == party.latitude && marker.position.longitude == party.longitude {
                selectedParty = party
                view.titleLabel.text = party.title
                view.imageView.image = party.image
            }
        }
        
        return view
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        performSegue(withIdentifier: StoryboardSegues.ToPartyMoreDetailsVC, sender: self)
    }
}

