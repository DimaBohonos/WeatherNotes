//
//  ContentView.swift
//  WeatherNotes
//
//  Created by dima on 01.05.2026.
//

import CoreData
import SwiftUI

struct ContentView: View {
    let viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext = PersistenceController.shared.viewContext) {
        self.viewContext = viewContext
    }

    var body: some View {
        NotesListView(context: viewContext)
    }
}

#Preview {
    ContentView()
}
