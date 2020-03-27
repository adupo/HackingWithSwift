//  My playground for learning more about Views and Modifiers!
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Aaron Dupont on 10/18/19.
//  Copyright © 2019 AaronDupont. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier{
    func body(content: _ViewModifier_Content<Title>) -> some  View {
        content
            //.font(.largeTitle)
            .foregroundColor(.blue)
        //other stuff
    }
}

//extension for View protocol to use modifier in easier way
extension View {
    func MainTitleStyle() -> some View {
        self.modifier(Title())
            .font(.largeTitle)
            .position(x: 100, y: 0)
    }
    func DifferentTitleStyle() -> some View {
        self.modifier(Title())
            .font(.body)
    }
}

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Hello World")
                .MainTitleStyle()
            //.modifier(Title())
            Text("Subheading Hello Worldie")
                .DifferentTitleStyle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
