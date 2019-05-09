//
//  MapViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/12/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var mapView: MKMapView?
    var window: UIWindow?
    var locationManager: CLLocationManager?
    let distanceSpan: Double = 500

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        window = UIWindow(frame: UIScreen.main.bounds)
        mapView = MKMapView(frame: CGRect(x: 0, y: 20, width: (window?.frame.width)!, height: (window?.frame.height)!))
        self.view.addSubview(mapView!)
        
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()

        }

    }
    
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation: CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan)
        mapView?.setRegion(region, animated: true)
        mapView?.showsUserLocation = true
    }
    
//end of class
}
