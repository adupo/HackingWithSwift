//
//  ContentView.swift
//  WeSplit
//
//  Created by Aaron Dupont on 10/9/19.
//  Copyright © 2019 AaronDupont. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkTotal = ""
    @State private var numPeople = ""
    @State private var tipPercentageSelection = 2
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var grandTotal: Double {
        let tipPercentage = Double(tipPercentages[tipPercentageSelection])
        let orderAmount = Double(checkTotal) ?? 0
        return orderAmount + (orderAmount / 100 * tipPercentage)
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(Int(numPeople) ?? 0 + 2)
        return grandTotal / peopleCount
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkTotal)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip", selection: $tipPercentageSelection){
                        ForEach (0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Total Due")){
                    Text("$\(grandTotal, specifier: "%.2f")")
                        .foregroundColor(tipPercentages[tipPercentageSelection] == 0 ? .red : .blue )
                }
                
                Section(header: Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
