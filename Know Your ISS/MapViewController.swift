//
//  MapViewController.swift
//  Know Your ISS
//
//  Created by Inesh Jupudy on 12/28/20.
//  Copyright © 2020 Inesh Jupudy. All rights reserved.
//


//Credits: Freepik

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var txtLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var MoreButton: UIButton!
    
    var lat: Double = 0
    var lon: Double = 0
    var string: String = "Hello World"
    
    @IBOutlet weak var mapView: MKMapView!
    
    var pin : Annotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let url = "https://api.wheretheiss.at/v1/satellites/25544"
        getData(url: url)
        
        Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { timer in
            let url = "https://api.wheretheiss.at/v1/satellites/25544"
            self.getData(url: url)
                    }
        
        txtLabel.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        txtLabel.textColor = .black
        
        
        
    }
        
    func getData(url: String){
            URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong !! ")
                return
            }
                var result : Info?
                do{
                    result = try JSONDecoder().decode(Info.self, from: data)
                }
                catch{
                    print("Oops! Something went wrong! \(error.localizedDescription)")
                }
                //json is the object with the data now
                guard let json = result else{
                    return
                }
                
                self.lat = json.latitude
                self.lon = json.longitude
                
                print("LATITUDE FROM API: \(self.lat)")
                print("LONGITUDE FROM API: \(self.lon)")
                
                let truncLat = Double(String(format: "%.1f", (self.lat * 10000)).dropLast(2))!/10000
                let truncLon = Double(String(format: "%.1f", (self.lon * 10000)).dropLast(2))!/10000
//                print("Truncated Latitude : \(truncLat)")
//                print("Truncated Longitude :\(truncLon)")

                
//                print("The International Space Station is at latitude \(String(self.lat)) and longitude \(String(self.lon)), at the speed of []km/hr")
                
                DispatchQueue.main.async {
                    self.updateMap(lat: self.lat, lon: self.lon)
                    self.txtLabel.text = "The International Space Station currently on latitude \(truncLat) and longitude \(truncLon), at the speed of \(json.velocity) km/hr"
                }
                
    //            DispatchQueue.main.async {
    //                let mvc = MapViewController()
    //                mvc.printLatLon(for: mvc.mapView, lat: self.lat, lon: self.lon)
    //            }
                
                
                }).resume()
        }
    
    @IBAction func btnClick(_ sender: Any) {
        let url = "https://api.wheretheiss.at/v1/satellites/25544"
        getData(url: url)
    }
    
    func updateMap(lat: Double, lon: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let region = MKCoordinateRegion (center: coordinate, latitudinalMeters: 5000000, longitudinalMeters: 5000000)
        self.mapView.setRegion(region, animated: true)

        self.pin = Annotation(title: "The ISS", subtitle: "International Space Station", coordinate: coordinate)
        
        let mapAnnotations = mapView.annotations
        mapView.removeAnnotations(mapAnnotations)
        self.mapView.addAnnotation(self.pin)
    }
    
    
    func printLatLon(for mapView: MKMapView, lat: Double, lon: Double) {
        print(lat)
        print(lon)
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let region = MKCoordinateRegion (center: coordinate, latitudinalMeters: 5000000, longitudinalMeters: 5000000)
        mapView.setRegion(region, animated: true)

        pin = Annotation(title: "The ISS", subtitle: "International Space Station", coordinate: coordinate)
        mapView.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
       let Identifier = "pin"
       let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
    
       annotationView.canShowCallout = true
          annotationView.image =  UIImage(imageLiteralResourceName: "satellite 3")
          return annotationView
    }
    
    
    @IBAction func mapTypeChange(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex
                   {
                   case 0:
                    mapView.mapType = MKMapType.standard
                   case 1:
                    mapView.mapType = MKMapType.hybrid
                   default:
                       break
                   }
    }
    
    
}
