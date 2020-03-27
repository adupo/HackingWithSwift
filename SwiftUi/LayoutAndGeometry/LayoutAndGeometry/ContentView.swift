//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Aaron Dupont on 3/3/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
        .offset(x: 100, y: 100)
        .background(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
