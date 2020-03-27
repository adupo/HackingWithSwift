//
//  Mission.swift
//  Moonshot
//
//  Created by Aaron Dupont on 12/17/19.
//  Copyright © 2019 AaronDupont. All rights reserved.
//

import Foundation



struct Mission: Codable, Identifiable {
    struct CrewRole:Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Appolo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
