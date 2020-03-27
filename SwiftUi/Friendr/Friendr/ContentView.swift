//
//  ContentView.swift
//  Friendr
//
//  Created by Aaron Dupont on 2/7/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var user: FetchedResults<User>
    @State private var users = [User]()
        //[User(id: "1", name: "Aaron"), User(id: "2",name: "HG")]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) { user in
                    NavigationLink(destination: DetailView(user: user)){
                        Text("\(user.wrappedName)")
                    }
                }
            }
            .onAppear(perform: loadUsers)
        .navigationBarTitle("Friendr")
        }
    }
    
    func loadUsers(){
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                    return
                } catch {
                    print(error)
                }
            }
            print("Woah, error: \(error?.localizedDescription ?? "Unkown Error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
