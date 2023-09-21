//
//  SwiftNotesApp.swift
//  SwiftNotes
//
//  Created by Lương Dương on 19/09/2023.
//

import SwiftUI
import SwiftData

@main
struct SwiftNotesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema: Schema = Schema([
            Note.self,
        ])
        let modelConfiguration: ModelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
