//
//  Timestamps.swift
//  Know Your ISS
//
//  Created by Inesh Jupudy on 1/28/21.
//  Copyright © 2021 Inesh Jupudy. All rights reserved.
//

import Foundation

struct Timestamps: Codable {
    var message: String
    var request: Content2
    var response: [Content]
}

struct Content: Codable{
    var duration: Int
    var risetime: Int
}

struct Content2: Codable{
    var altitude: Int
    var datetime: Int
    var latitude: Double
    var longitude: Double
    var passes: Int
}
