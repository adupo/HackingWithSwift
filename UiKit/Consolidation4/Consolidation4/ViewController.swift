//
//  ViewController.swift
//  Consolidation4
//
//  Created by Aaron Dupont on 2/16/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var usedLetters: UILabel!
    
    let answerWord = "technical" //the answer
    var usedLettersString = "" {
        didSet {
            usedLetters.text = usedLettersString
        }
    }
    var guessedWord = "" { //the display to the user
        didSet {
            title = guessedWord
        }
    }
    var wrongGuesses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(guessLetterPrompt))
        
        guessedWord = String.init(repeating: "?", count: answerWord.count)
        
        
    }
    
    func guessFor(_ letter: Character) {
        guessedWord = ""
        usedLettersString.append(letter)
        
        for char in answerWord {
            if usedLettersString.contains(char) {
                guessedWord.append(String(char))
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
            if letter.count > 1 {
                return
            } else {
                self?.guessFor(Character(letter))
            }
        }
        ac.addAction(submit)
        present(ac, animated: true)
      }


}

