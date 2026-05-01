//
//  NotesListView.swift
//  WeatherNotes
//

import CoreData
import SwiftUI

struct NotesListView: View {
    private let context: NSManagedObjectContext
    private let weather: WeatherServicing
    @State private var viewModel: NotesListViewModel
    @State private var isPresentingComposer = false

    init(context: NSManagedObjectContext, weather: WeatherServicing = WeatherService()) {
        self.context = context
        self.weather = weather
        _viewModel = State(initialValue: NotesListViewModel(context: context))
    }

    var body: some View {
        NavigationStack {
            mainContent
                .navigationDestination(for: UUID.self) { noteID in
                    NoteDetailView(noteID: noteID, context: context)
                }
                .navigationTitle("Weather notes")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            isPresentingComposer = true
                        } label: {
                            Label("Add note", systemImage: "plus.circle.fill")
                        }
                        .accessibilityHint("Adds a note with current Kyiv weather.")
                    }
                }
                .sheet(isPresented: $isPresentingComposer) {
                    AddNoteView(context: context, weather: weather) {
                        viewModel.refresh()
                    }
                }
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
                description: Text("Tap + to add a note—we'll attach the Kyiv-area weather.")
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
