//
//  NotesListViewModel.swift
//  WeatherNotes
//

import CoreData
import Foundation

@Observable
@MainActor
final class NotesListViewModel {
    private let context: NSManagedObjectContext
    private(set) var summaries: [NoteSummary] = []
    private(set) var errorMessage: String?

    init(context: NSManagedObjectContext) {
        self.context = context
        refresh()
    }

    func refresh() {
        let request = Note.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Note.createdAt, ascending: false)
        ]
        do {
            let notes = try context.fetch(request)
            summaries = notes.map { NoteSummary(managed: $0) }
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
            summaries = []
        }
    }
}
