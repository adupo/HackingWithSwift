//
//  ContentView.swift
//  iConvert
//
//  Created by Aaron Dupont on 10/13/19.
//  Copyright © 2019 AaronDupont. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var units = ["seconds", "minutes", "hours", "days"]
    @State private var inputUnitSelection = 0
    @State private var outputUnitSelection = 2
    @State private var inputNumber = ""
    
    var inputInSeconds: Double {
        switch units[inputUnitSelection] {
        case "seconds":
            return Double(inputNumber) ?? 0
        case "minutes":
            return 60 * (Double(inputNumber) ?? 0)
        case "hours":
            return 3600 * (Double(inputNumber) ?? 0)
        case "days":
            return 86400 * (Double(inputNumber) ?? 0)
        default:
            return 0
        }
    }
    
    var outputNumber: Double {
        switch units[outputUnitSelection] {
        case "seconds":
            return inputInSeconds
        case "minutes":
            return inputInSeconds/60
        case "hours":
            return inputInSeconds/3600
        case "days":
            return inputInSeconds/86400
        default:
            return 0
        }    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField ("number to convert", text: $inputNumber)
                Section(header: Text("From")) {
                    Picker("input unit", selection: $inputUnitSelection){
                        ForEach(0..<units.count){
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("To")) {
                    Picker("output unit", selection: $outputUnitSelection){
                        ForEach(0..<units.count){
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Text("\(outputNumber)")
            }
        .navigationBarTitle("iConvert")
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
