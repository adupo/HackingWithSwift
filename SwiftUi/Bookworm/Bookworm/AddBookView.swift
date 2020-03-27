//
//  AddBookView.swift
//  Bookworm
//
//  Created by Aaron Dupont on 1/28/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    private var invalidForm: Bool {
        if self.title == "" || author == "" || genre == "" || review == "" {
         return true
        }
        
        return false
    }
    
    let genres = ["Fantasy", "Horror", "Romance", "Thriller", "Mystery"]
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title of book", text: $title)
                    TextField("Name of author", text: $author)
                    
                    Picker("Genre", selection: $genre)
                    {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    
                    RatingView(rating: $rating)
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text("\($0)")
//                        }
//                    }
                    
                    TextField("write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(self.invalidForm)
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
