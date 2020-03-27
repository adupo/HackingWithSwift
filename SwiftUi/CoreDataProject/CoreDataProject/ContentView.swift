//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Aaron Dupont on 2/5/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//
import CoreData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
