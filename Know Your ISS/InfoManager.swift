//
//  InfoManager.swift
//  Know Your ISS
//
//  Created by Inesh Jupudy on 12/28/20.
//  Copyright © 2020 Inesh Jupudy. All rights reserved.
//

import Foundation

struct Info: Decodable {
    let name : String
    let id : Int
    let latitude : Double
    let longitude : Double
    let altitude : Double
    let velocity : Double
    let visibility : String
    let footprint : Double
    let timestamp : Int
    let daynum : Double
    let solar_lat : Double
    let solar_lon : Double
    let units : String
    
}


   
