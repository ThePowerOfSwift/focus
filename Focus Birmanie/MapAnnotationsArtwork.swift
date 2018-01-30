//
//  MapAnnotationsArtwork.swift
//  Focus Birmanie
//
//  Created by Georgia Leguem on 01/10/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotationsArtwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
