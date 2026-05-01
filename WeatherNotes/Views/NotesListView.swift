//
//  NotesListView.swift
//  WeatherNotes
//

import CoreData
import SwiftUI

struct NotesListView: View {
    private let context: NSManagedObjectContext
    @State private var viewModel: NotesListViewModel

    init(context: NSManagedObjectContext) {
        self.context = context
        _viewModel = State(initialValue: NotesListViewModel(context: context))
    }

    var body: some View {
        NavigationStack {
            mainContent
                .navigationDestination(for: UUID.self) { noteID in
                    NoteDetailView(noteID: noteID, context: context)
                }
                .navigationTitle("Weather notes")
        }
        .onAppear { viewModel.refresh() }
    }

    @ViewBuilder
    private var mainContent: some View {
        if let message = viewModel.errorMessage {
            ContentUnavailableView(
                "Couldn't load notes",
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )
        } else if viewModel.summaries.isEmpty {
            ContentUnavailableView(
                "No notes yet",
                systemImage: "note.text",
                description: Text("Notes you save will appear here.")
            )
        } else {
            List {
                ForEach(viewModel.summaries) { item in
                    NavigationLink(value: item.id) {
                        NoteRowView(item: item)
                    }
                    .buttonStyle(.plain)
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}
