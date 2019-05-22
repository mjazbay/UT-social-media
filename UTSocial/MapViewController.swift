//
//  MapViewController.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 4/12/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var mapView: MKMapView!
    var window: UIWindow!

//    var locationManager = CLLocationManager()

    let distanceSpan: Double = 500
    var points: [CLLocationCoordinate2D] = []   //[CLLocationCoordinate2D]()
    var fortyAcres: [CLLocationCoordinate2D] = []
    
    let myFortyAcres = FortyAcres.getFortyAcres()
    var myPoints = [CLLocationCoordinate2D]()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        mapView.showsUserLocation = true
//        requestLocationAccess()

        // Do any additional setup after loading the view.
        window = UIWindow(frame: UIScreen.main.bounds)
        mapView = MKMapView(frame: CGRect(x: 0, y: 20, width: window.bounds.width, height: window.bounds.height))
        mapView.delegate = self

        
        let mapCenter = CLLocationCoordinate2D(latitude: 30.286482, longitude: -97.739995)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let mapRegion = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        mapView.setRegion(mapRegion, animated: true)
        
        
        let coords = [(30.29128,-97.73858), (30.28685,-97.73659), (30.28081,-97.73734), (30.28071,-97.73589), (30.27658,-97.73182), (30.28361,-97.73650), (30.28265,-97.73675), (30.28575,-97.72920), (30.28240,-97.73074), (30.28398,-97.73792), (30.27830,-97.72978), (30.28240,-97.73788), (30.28604,-97.73135), (30.28420,-97.74124), (30.28892,-97.73634), (30.28845,-97.74245), (30.28767,-97.73293), (30.28929,-97.74066), (30.28140,-97.73875), (30.28037,-97.73252), (30.28442,-97.73949), (30.29113,-97.73717), (30.27415,-97.73996), (30.29017,-97.73850), (30.28361,-97.73252), (30.28015,-97.73891), (30.28663,-97.74116), (30.27887,-97.73348), (30.28619,-97.74033), (30.28565,-97.73921), (30.28398,-97.73036), (30.28656,-97.73783)]
        
        for (latitude, longitude) in coords
        {
            let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            points.append(coord)
        }
//        print(points)

        self.view.addSubview(mapView)

        
//        addPolyLine()
//        addPolygon()
        

//        LONG PRESS TO GET THE COORDINATES
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
//        mapView?.addGestureRecognizer(longPressGesture)
//        longPressGesture.minimumPressDuration = 0.1
        
//        let myString = myFortyAcres[0] as! String
        var array = myFortyAcres.components(separatedBy: ", ")
        
//        for i in stride(from: 0, to: array.count, by: 1)
//        {
//            array[i] = array[i].replacingOccurrences(of: "\n\t\t\t\t", with: "", options: .literal, range: nil)
//        }
        var stringArray = [String]()
        var numberArray = [Double]()
        for myString in array
        {
//            var newString = myString.trimmingCharacters(in: CharacterSet.init(charactersIn: "\n\t\t\t\t(( ( )"))
            var newString = myString.trimmingCharacters(in: CharacterSet.init(charactersIn: "\n\t\t\t\t[__C.CLLocationCoordinate2D(latitude: longitude: ) ]"))
//            var newArray = newString.components(separatedBy: ",")
//            for aString in newArray
//                {
//                    numberArray.append(Double(aString) as! Double)
//                }
            

//            print(newString)
            numberArray.append(Double(newString) as! Double)
//            stringArray.append(newString)
        }
        print(numberArray)
//        print(stringArray)
        for i in stride(from: 0, through: numberArray.count - 2, by: 2)
        {
            let latitude = numberArray[i]
            let longitude = numberArray[i+1]
            let point = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            myPoints.append(point)
        }
//
//        print(myPoints)
//
        addPolyLine()
        addPolygon()
        
       
    }
    
    func addPolyLine()
    {
        let polyLine = MKPolyline(coordinates: myPoints, count: myPoints.count)
        mapView.addOverlay(polyLine)
    }

    func addPolygon()
    {
        let polygon = MKPolygon(coordinates: myPoints, count: myPoints.count)
        mapView?.addOverlay(polygon)
    }
//
//
//
//    func requestLocationAccess() {
//        let status = CLLocationManager.authorizationStatus()
//
//        switch status {
//        case .authorizedAlways, .authorizedWhenInUse:
//            return
//
//        case .denied, .restricted:
//            print("location access denied")
//
//        default:
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//
    

    

    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline
        {
            let testlineRenderer = MKPolylineRenderer(overlay: polyline)
            testlineRenderer.strokeColor = .blue
            testlineRenderer.lineWidth = 5
            return testlineRenderer
        }

//        if overlay is MKPolyline
//        {
//            let renderer = MKPolylineRenderer(overlay: overlay)
//            renderer.strokeColor = .orange
//            renderer.lineWidth = 3
//            return renderer
//        }
        else if overlay is MKPolygon
        {
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            renderer.fillColor = .orange
            renderer.alpha = 0.5//.black.withAlphaComponent(0.5)
            renderer.strokeColor = .orange
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer()
    }
    

    
    
    
    
//    @objc func longPress(gesture: UILongPressGestureRecognizer)
//    {
//        let touchPoint = gesture.location(in: self.mapView)
//        let coordinate = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        self.mapView.addAnnotation(annotation)
//
//        self.fortyAcres.append(annotation.coordinate)
//
//        let myPolyLine = MKPolyline(coordinates: fortyAcres, count: fortyAcres.count)
//        self.mapView.addOverlay(myPolyLine)
////        print(self.fortyAcres)
//    }
    
//end of class
    }



