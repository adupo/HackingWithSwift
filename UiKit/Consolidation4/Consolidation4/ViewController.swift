//
//  ViewController.swift
//  Consolidation4
//
//  Created by Aaron Dupont on 2/16/21.
//

import UIKit

class ViewController: UIViewController {
    
    let word = "technical"
    var usedLetters = ""
    var guessedWord = "" {
        didSet {
            title = guessedWord
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(guessLetterPrompt))
        
        guessedWord = String.init(repeating: "?", count: word.count)
        
        
    }
    
    func guessFor(_ letter: Character) {
        for letter in word {
            if usedLetters.contains(letter) {
                guessedWord.append(String(letter))
            } else {
                guessedWord.append("?")
            }
        }
    }
    
    @objc func guessLetterPrompt() {
        let ac = UIAlertController(title: "Guess one letter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submit = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let letter = ac?.textFields?[0].text else { return }
            self?.guessFor(letter)
        }
        ac.addAction(submit)
        present(ac, animated: true)
      }


}

