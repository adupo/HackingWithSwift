//
//  ViewController.swift
//  Project2
//
//  Created by Aaron Dupont on 3/27/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var Button1: UIButton!
    @IBOutlet var Button2: UIButton!
    @IBOutlet var Button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        Button1.layer.borderWidth = 1
        Button2.layer.borderWidth = 1
        Button3.layer.borderWidth = 1
        Button1.layer.borderColor = UIColor.lightGray.cgColor
        Button2.layer.borderColor = UIColor.lightGray.cgColor
        Button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        round += 1
        
        Button1.setImage(UIImage(named: countries[0]), for: .normal)
        Button2.setImage(UIImage(named: countries[1]), for: .normal)
        Button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Guess: " + countries[correctAnswer].uppercased() + " - Score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var additionalMessage = ""
        
        if sender.tag == correctAnswer {
            title = "Corrrect!"
            score += 1
        } else {
            title = "Wrongo :("
            additionalMessage = "BTW, thats the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score). "+additionalMessage, preferredStyle: .alert)
        
        if (round == 10) {
            if (score > 5) {
                title = "You passed!"
            } else {
                title = "This is troubling..."
            }
            score = 0
            round = 0
            ac.title = title
            ac.addAction(UIAlertAction(title: "Start Over", style: .destructive, handler: askQuestion))        }
        else {
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        present(ac, animated: true)
    }
    
}

