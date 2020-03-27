//
//  ContentView.swift
//  BetterRest
//
//  Created by Aaron Dupont on 10/22/19.
//  Copyright © 2019 AaronDupont. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeup = defaultWakeupTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
    
    static var defaultWakeupTime: Date {
        var component = DateComponents()
        component.hour = 8
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
            Form {
               
//                Picker("Daily coffe intake", selection: $coffeeAmount) {
//                    ForEach (1 ... 20, id: \.self)  {
//                        Text("\($0)")
//                   }
//                }
//                .pickerStyle(WheelPickerStyle())
//                Not attractive
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wakeup?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeup, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())}
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Stepper(value: $coffeeAmount, in: 1...20){
                        if (coffeeAmount == 1){
                            Text("\(coffeeAmount) cup")
                        }
                        else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle("BetterRest")
//            .navigationBarItems(trailing: Button(action: calculateBedTime){
//                Text("Calculate")
//                }
//            )
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Goodnight")))
            }
            Text("Your bedtime is at")
            Text("\(calculateBedTime())")
                .font(.system(size: 100))
            }
            Spacer()
        }
    }
    func calculateBedTime() -> String{
           let model = SleepCalculator()
           let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
           let hour = (components.hour ?? 0) * 60 * 60
           let minute = (components.minute ?? 0) * 60
           
           do {
               let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
               let sleepTime = wakeup - prediction.actualSleep
               let formatter = DateFormatter()
               formatter.timeStyle = .short
               return formatter.string(from: sleepTime)
           }
           catch {
               return "Something went wrong"
           }
       }
    
//    func calculateBedTime(){
//        let model = SleepCalculator()
//        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
//        let hour = (components.hour ?? 0) * 60 * 60
//        let minute = (components.minute ?? 0) * 60
//
//        do {
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//            let sleepTime = wakeup - prediction.actualSleep
//            let formatter = DateFormatter()
//            formatter.timeStyle = .short
//            alertMessage = formatter.string(from: sleepTime)
//            alertTitle = "Your ideal bedtime is..."
//        }
//        catch {
//            alertTitle = "Something went wrong"
//            alertMessage = "There was an error predicting your bedtime. Head to bed immediately!"
//        }
//        showingAlert = true
//    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
