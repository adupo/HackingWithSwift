//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Aaron Dupont on 1/9/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select your cake type",
                       selection: $order.type){
                        ForEach(0..<Order.types.count) {
                        Text(Order.types[$0])
                       }
                }
                Stepper(value: $order.quantity, in: 3...20) {
                    Text("Number of cakes: \(order.quantity)")
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestsEnabled
                        .animation()) {
                            Text("Special Requests?")
                    }
                    
                    if order.specialRequestsEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Extra Frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles)
                        {
                            Text("Extra Sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)){
                        Text("Delivery Details")
                    }
                }
            }
        .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
