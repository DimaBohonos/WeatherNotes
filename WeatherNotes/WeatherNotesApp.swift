//
//  WeatherNotesApp.swift
//  WeatherNotes
//
//  Created by dima on 01.05.2026.
//

import SwiftUI

@main
struct WeatherNotesApp: App {
    private let persistence = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(viewContext: persistence.viewContext)
                .environment(\.managedObjectContext, persistence.viewContext)
        }
    }
}
