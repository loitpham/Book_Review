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
                                Text(book.author ?? "Unknown author")
                                    .foregroundColor(.secondary)
                            }
                    }
                }
            }
                .navigationBarTitle("Book Review")
                .navigationBarItems(trailing: Button(action: { showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                }
                )
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, moc)
                }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
