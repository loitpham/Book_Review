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
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            Text("Count: \(books.count)")
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
