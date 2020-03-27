//
//  Resort.swift
//  SnowSeaker
//
//  Created by Aaron Dupont on 3/4/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
}
