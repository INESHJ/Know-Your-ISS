//
//  MapViewController.swift
//  Know Your ISS
//
//  Created by Inesh Jupudy on 12/28/20.
//  Copyright © 2020 Inesh Jupudy. All rights reserved.
//

import UIKit
import MapKit

let instance = ViewController()

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var pin : Annotation!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let coordinate = CLLocationCoordinate2D(latitude: instance.lat, longitude: instance.lon)
        
        let region = MKCoordinateRegion (center: coordinate, latitudinalMeters: 5000000, longitudinalMeters: 5000000)
        mapView.setRegion(region, animated: true)


        pin = Annotation(title: "AppleHQ", subtitle: "APPLE HeadQuarters!", coordinate: coordinate)
        mapView.addAnnotation(pin)
        
        print(instance.lat)
        print(instance.lon)
        print(instance.stringtrial)
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: pin, reuseIdentifier: "HQPin")
        annotationView.image = UIImage(named: "satellite")
        annotationView.canShowCallout = true
        return annotationView
    }
    
}
