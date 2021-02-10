//
//  PeopleAboard.swift
//  Know Your ISS
//
//  Created by Inesh Jupudy on 1/24/21.
//  Copyright © 2021 Inesh Jupudy. All rights reserved.
//

import Foundation

struct Response: Decodable{
    let message: String
    let number: Int
    let people: names
}

struct names: Decodable{
    let craft: String
    let name: String
}

