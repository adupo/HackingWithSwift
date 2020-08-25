//
//  Petition.swift
//  Project7
//
//  Created by Aaron Dupont on 8/24/20.
//  Copyright © 2020 Aaron Dupont. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
