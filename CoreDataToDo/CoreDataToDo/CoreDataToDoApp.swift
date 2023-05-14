//
//  CoreDataToDoApp.swift
//  CoreDataToDo
//
//  Created by Leandro Carvalho on 11/05/23.
//

import SwiftUI

@main
struct CoreDataToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
