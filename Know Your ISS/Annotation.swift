//
//  Annotation.swift
//  Know Your ISS
//
//  Created by Inesh Jupudy on 12/28/20.
//  Copyright © 2020 Inesh Jupudy. All rights reserved.
//

import MapKit

class Annotation: NSObject, MKAnnotation{
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
    }
}
