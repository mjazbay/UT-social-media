//
//  FortyAcres.swift
//  UTSocial
//
//  Created by Maksat Zhazbayev on 5/11/19.
//  Copyright © 2019 Maksat Zhazbayev. All rights reserved.
//

import UIKit
import MapKit

class FortyAcres: NSObject {

var coordinate: String//[CLLocationCoordinate2D]!

init(coordinate: String) //[CLLocationCoordinate2D])
{
self.coordinate	= coordinate
}

static func getFortyAcres() -> String
{
    guard let path = Bundle.main.path(forResource: "FortyAcres", ofType: "plist"), let dictionary = NSDictionary(contentsOfFile: path) else{return "nothing" }

//    var fortyAcres = [FortyAcres]()
//    let coordinates = FortyAcres(coordinate: array as! [CLLocationCoordinate2D])
//    fortyAcres.append(coordinates)

    return dictionary["coordinates"] as! String
//    return fortyAcres as [FortyAcres]

}
}
