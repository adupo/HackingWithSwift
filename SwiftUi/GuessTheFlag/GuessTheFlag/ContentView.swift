//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Aaron Dupont on 10/15/19.
//  Copyright © 2019 AaronDupont. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var imageTitle: String
    
    var body: some View {
        Image(imageTitle)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black,lineWidth: 0.5))
        .shadow(color: .white, radius: 4)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var dismissText = ""
    @State private var score = 0
    @State private var animationAmount = 0.0
    
    var body: some View{
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray,.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        withAnimation {
                        self.flagtapped(number)
                        }
                    }) {
                        FlagImage(imageTitle: self.countries[number])
                        
//                        Image(self.countries[number])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .overlay(Capsule().stroke(Color.black,lineWidth: 0.5))
//                            .shadow(color: .white, radius: 4)
                    }
                    .rotation3DEffect(.degrees(self.animationAmount), axis: (x: 0, y: 1, z: 0))
                }
                Spacer()
                Text("\(score)")
                    .foregroundColor(.white)
                    .font(.custom("", size: 150))
                    .fontWeight(.light)
                    .shadow(color: .white, radius: 10)
                Spacer()
                
            }
            .alert(isPresented: $showingScore){
                Alert(title: Text(scoreTitle), message: Text("Your score is now \(score)."), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
        
    }
    func flagtapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Good job!"
            scoreMessage = "Your score went up one point!"
            dismissText = ""
            score += 1
            animationAmount += 360
        }
        else {
            scoreTitle = "Uh oh"
            scoreMessage = "That was the flag for \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
