//
//  ContentView.swift
//  habitual
//
//  Created by Aaron Dupont on 1/2/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import SwiftUI
struct Habit: Identifiable {
    let id = UUID()
    let title: String
    let body: String
}

class Habits: ObservableObject {
    @Published var habits: [Habit]
    init () {
        habits = [Habit(title: "Learn SwiftUI", body:  "maybe actually do it 1 hour per day")]
    }
//    = Habit(id: "1", title: "title1", body: "body1")
}
struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var showingAddHabit: Bool = false
    var body: some View {
        NavigationView {
            List{
                ForEach(habits.habits){ habit in
                    Text(habit.title)
                }
                .onDelete(perform: removeItems)
            }
        .navigationBarTitle("Habits")
        .navigationBarItems(leading: EditButton(), trailing:
            Button(action: {
                self.showingAddHabit = true
            }){
                Image(systemName: "plus")
            })
        .sheet(isPresented: $showingAddHabit) {
            Text("do something")//show new view here
            }
        }
    }
    
    func removeItems(at Offsets: IndexSet){
        habits.habits.remove(atOffsets: Offsets)
//        expenses.items.remove(atOffsets: Offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
