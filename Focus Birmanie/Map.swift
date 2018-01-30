//
//  Map.swift
//  Focus Birmanie
//
//  Created by Laurent Aubourg on 08/02/2017.
//  Copyright © 2017 appedufun. All rights reserved.
//

import Foundation

import MapKit
import UIKit
class Map: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var info: String = ""
    
     init(title:String,info:String,coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.info = info
        self.coordinate = coordinate
        
        super.init()
    
    }
    func coordinates()->Dictionary<String, AnyObject>{
           return pl!.coordinate()
    }
    deinit{
     
    }
}
