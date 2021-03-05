//
//  Person.swift
//  Project10
//
//  Created by Aaron Dupont on 3/5/21.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
