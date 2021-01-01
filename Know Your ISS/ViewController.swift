//
//  ViewController.swift
//  Know Your ISS
//
//  Created by Inesh Jupudy on 12/28/20.
//  Copyright © 2020 Inesh Jupudy. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var btnClick: UIButton!
    
    var lat: Double = 0
    var lon: Double = 0
    var stringtrial = "Hi"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.makeRounded(btnClick)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func makeRounded(_ object:AnyObject){
        object.layer.cornerRadius = (object.frame?.size.width)! / 2
        object.layer?.masksToBounds = true
    }
    
    @IBAction func apiCall(_ sender: Any) {
        func getData(from url: String){
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
                    
                    print(self.lat)
                    print(self.lon)
                    
                    }).resume()
            }
        
        let url = "https://api.wheretheiss.at/v1/satellites/25544"
        getData(from: url)
        
    }
    
}

