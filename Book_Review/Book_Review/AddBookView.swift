//
//  AddBookView.swift
//  Book_Review
//
//  Created by Loi Pham on 7/5/21.
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
    @State private var showingIncompleteAlert = false
    
    private var date = Date()
    
    private var isValid: Bool {
        return !(title.isEmpty || author.isEmpty || genre.isEmpty)
    }
    
    private var message = "Please make sure to fill out title, author, and select a genre"
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    func getFormattedDate(date: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        return dateformatter.string(from: date)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text(getFormattedDate(date: date))
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    RatingView(rating: $rating)
                    
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        if isValid {
                            let newBook = Book(context: moc)
                            newBook.title = title
                            newBook.author = author
                            newBook.rating = Int16(rating)
                            newBook.genre = genre
                            newBook.review = review
                            newBook.date = date
                            
                            try? moc.save()
                            
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            showingIncompleteAlert = true
                        }
                    }
                }
            }
            .navigationBarTitle("Add Book")
            .alert(isPresented: $showingIncompleteAlert) {
                Alert(title: Text("Missing info"), message: Text(message), dismissButton: .default(Text("OK")))
            }
            
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
