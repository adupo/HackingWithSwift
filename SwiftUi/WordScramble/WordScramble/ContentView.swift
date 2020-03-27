//
//  ContentView.swift
//  WordScramble
//
//  Created by Aaron Dupont on 10/27/19.
//  Copyright © 2019 AaronDupont. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = "Test"
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Your guess:", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Alright")))
            })
                .navigationBarItems(trailing: Button(action: startGame){
                    Text("Restart")
                    }
            )
        }
    }
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        guard isOrigional(word: answer) else {
            wordError(title: "Duplicate", message: "That word has already been used")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Uh, this is awkward..", message: "\(answer) cannot be derived from the given word")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Yikes", message: "That is not even a real word 😆")
            return
        }
        
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame(){
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle!")
    }
    
    func isOrigional(word: String) -> Bool {
        if usedWords.contains(word) {
            return false
        }
        if word == rootWord {
            return false
        }
        return true
    }
    
    func isPossible(word: String) -> Bool {
        var tempword = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempword.firstIndex(of: letter) {
                tempword.remove(at: pos)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
//        if word.count <= 3 {
//            return false
//        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return mispelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
