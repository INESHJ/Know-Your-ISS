//
//  MoreViewController.swift
//  Know Your ISS
//
//  Created by Inesh Jupudy on 1/20/21.
//  Copyright © 2021 Inesh Jupudy. All rights reserved.
//

//Credits: Prosymbols
//<div>Icons made by <a href="https://www.flaticon.com/authors/vitaly-gorbachev" title="Vitaly Gorbachev">Vitaly Gorbachev</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>

import Foundation
import UIKit
import CoreLocation

class MoreViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func didTapButton(){
        let vc = storyboard?.instantiateViewController(identifier: "moresecond") as! MoreViewController3
        navigationController?.pushViewController(vc, animated: true)
    }
}


//Second view controller

class MoreViewController2: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var manager: CLLocationManager?
    var lat = 0.0
    var lon = 0.0
    var timeArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager = CLLocationManager()
        
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.requestWhenInUseAuthorization()
        manager?.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else{
            return
        }
        
//        userCoordinatesLabel.text = "\(first.coordinate.longitude) | \(first.coordinate.latitude)"
        
        lat = first.coordinate.latitude
        lon = first.coordinate.longitude
        
        print(" Lat from User : \(lat)")
        print(" Lon from User : \(lon)")
        
        let url = "http://api.open-notify.org/iss-pass.json?lat=\(self.lat)&lon=\(self.lon)&n=5"
        fetchPostData(url: url)
        
    }
    
    func fetchPostData(url: String){
        URLSession.shared.dataTask(with: URL(string: url)!) { [self] (data, response, error) in
            guard let data = data, error == nil else {
                print("Something went wrong!")
                return
            }
            var theresponse : Timestamps?
            do{
                theresponse = try JSONDecoder().decode(Timestamps.self, from: data)
            }
            catch{
                print("Oops! Something went wrong! \(error.localizedDescription)")
            }
            guard let json1 = theresponse else{
                return
            }
            
            print(json1.message)
            print(json1.request.passes)
            print(json1.response.count)
            print(json1.response[4])
            
            let time = json1.response[0].risetime
            let time2 = json1.response[1].risetime
            let time3 = json1.response[2].risetime
            let time4 = json1.response[3].risetime
            let time5 = json1.response[4].risetime
            
            let date = Date(timeIntervalSince1970: TimeInterval(time))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "yyyy-MM-dd 'at' HH:mm"//Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            
            let date2 = Date(timeIntervalSince1970: TimeInterval(time2))
            let dateFormatter2 = DateFormatter()
            dateFormatter2.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter2.locale = NSLocale.current
            dateFormatter2.dateFormat = "yyyy-MM-dd 'at' HH:mm"//Specify your format that you want
            let strDate2 = dateFormatter2.string(from: date2)
            
            let date3 = Date(timeIntervalSince1970: TimeInterval(time3))
            let dateFormatter3 = DateFormatter()
            dateFormatter3.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter3.locale = NSLocale.current
            dateFormatter3.dateFormat = "yyyy-MM-dd 'at' HH:mm"//Specify your format that you want
            let strDate3 = dateFormatter3.string(from: date3)
            
            let date4 = Date(timeIntervalSince1970: TimeInterval(time4))
            let dateFormatter4 = DateFormatter()
            dateFormatter4.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter4.locale = NSLocale.current
            dateFormatter4.dateFormat = "yyyy-MM-dd 'at' HH:mm"//Specify your format that you want
            let strDate4 = dateFormatter4.string(from: date4)
            
            let date5 = Date(timeIntervalSince1970: TimeInterval(time5))
            let dateFormatter5 = DateFormatter()
            dateFormatter5.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
            dateFormatter5.locale = NSLocale.current
            dateFormatter5.dateFormat = "yyyy-MM-dd 'at' HH:mm"//Specify your format that you want
            let strDate5 = dateFormatter5.string(from: date5)
            
            //print("String with at \(strDate5)")
            //the dates are:-
//            print(strDate)
//            print(strDate2)
//            print(strDate3)
//            print(strDate4)
            print(strDate5)
            
            timeArray = []
            
            timeArray.append(strDate)
            timeArray.append(strDate2)
            timeArray.append(strDate3)
            timeArray.append(strDate4)
            timeArray.append(strDate5)
            
            DispatchQueue.main.async {
                
                tableView.reloadData()
            }
        }.resume()
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell ID", for: indexPath)
        cell.textLabel?.text = "Pass over #\(indexPath.row + 1)\n\(timeArray[indexPath.row])"
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .lightGray
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}






class MoreViewController3: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
