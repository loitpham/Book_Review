//
//  ContentView.swift
//  Book_Review
//
//  Created by Loi Pham on 7/4/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(
                        destination: DetailView(book: book)) {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? Color.red : Color.primary)
                                Text(book.author ?? "Unknown author")
                                    .foregroundColor(.secondary)
                                
                                Text(getFormattedDate(date: book.date ?? Date()))
                                    .foregroundColor(.secondary)
                            }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationBarTitle("Book Review")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: { showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                }
                )
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, moc)
                }
        }
    }
    
    func getFormattedDate(date: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        return dateformatter.string(from: date)
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
