//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Aaron Dupont on 1/13/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order:Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorAlert = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $errorAlert) {
            Alert(title: Text("Awkward..."), message: Text("There was an issue processing your order."), dismissButton: .default(Text("Try Again")) {
                self.placeOrder()
            })
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("failed to encode")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                        print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                        self.errorAlert = true
                        return
                      }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.errorAlert = false
                self.showingConfirmation = true
            } else {
                self.errorAlert = true
                print("Invalid response from server")
            }
        }.resume()
    }
}



struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
