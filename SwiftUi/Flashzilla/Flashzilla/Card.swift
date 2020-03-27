//
//  Card.swift
//  Flashzilla
//
//  Created by Aaron Dupont on 2/26/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who is the best at ping pong?", answer: "Aaron, duh")
    }
}
