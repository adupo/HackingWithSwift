//
//  ViewController.swift
//  Project12
//
//  Created by Aaron Dupont on 3/16/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        defaults.set(25, forKey: "Age")
        let age = defaults.integer(forKey: "Age")
        print(age)
        
    }


}

