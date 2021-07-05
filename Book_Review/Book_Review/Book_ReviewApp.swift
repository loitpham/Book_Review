//
//  Book_ReviewApp.swift
//  Book_Review
//
//  Created by Loi Pham on 7/4/21.
//

import SwiftUI

@main
struct Book_ReviewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
