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

struct Response : Decodable{
    let message: String
    let number: Int
    let people: Names
}

struct Names: Decodable{
    let craft : String
    let name: String
}

class MoreViewController: UIViewController{
    
    var Names = [Response]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func didTapButton(){
        let vc = storyboard?.instantiateViewController(identifier: "moresecond") as! MoreViewController2
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //fetching data from api
    

}


//Second view controller

class MoreViewController2: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        //title = "When does the ISS pass over you?"
    }
    @IBAction func didTapButton(){
        navigationController?.popViewController(animated: true)
    }
}
