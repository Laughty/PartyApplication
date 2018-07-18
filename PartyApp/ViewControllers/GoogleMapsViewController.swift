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


class GoogleMapsViewController:
UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
 //   @IBOutlet var googleMaps: GMSMapView!
    
    @IBOutlet var googleMaps: GMSMapView!
    var locationManager = CLLocationManager()
    var locationStart = CLLocation()
    var locationStop = CLLocation()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.googleMaps.delegate = self
        checkLocationAuthorizationStatus()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.googleMaps.clear()
        self.locationStop = CLLocation(latitude: currentParty.location[0], longitude: currentParty.location[1])
        if (locationManager.location != nil){
            locationStart = locationManager.location!
        }
        self.googleMaps.camera = GMSCameraPosition(target: locationStart.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        
        createMarker(title:currentParty.title , location: locationStop)
        drawPatch(startLocation: self.locationStart, stopLocation: self.locationStop)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            
        } else {
            //            centerMapOnLocation(location: CLLocation(latitude: parties.first!.location[0], longitude: parties.first!.location[1]))
            locationManager.requestAlwaysAuthorization()
        }
    }
    

    

    func createMarker(title:String, location:CLLocation){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude,    longitude:location.coordinate.longitude)
        marker.title = title
        marker.map = googleMaps
        
        
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func drawPatch(startLocation:CLLocation, stopLocation:CLLocation){
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destanation = "\(stopLocation.coordinate.latitude),\(stopLocation.coordinate.longitude)"
    
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destanation)&mode=driving&key=AIzaSyC6AZgUwTCF97I-4FqEeBZkKgXFeR3NnGA"
        
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
            //let json = JSON(data: response.data!)
            //let routes = json["routes"].arrayValue
            
            
        }
    }
    

}
