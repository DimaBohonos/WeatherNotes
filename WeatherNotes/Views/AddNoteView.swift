//
//  AddNoteView.swift
//  WeatherNotes
//

import CoreData
import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var noteText = ""
    @FocusState private var editorFocused: Bool
    @State private var viewModel: AddNoteViewModel

    private let onSaved: () -> Void

    init(
        context: NSManagedObjectContext,
        weather: WeatherServicing,
        onSaved: @escaping () -> Void
    ) {
        _viewModel = State(initialValue: AddNoteViewModel(context: context, weather: weather))
        self.onSaved = onSaved
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextEditor(text: $noteText)
                        .frame(minHeight: 140)
                        .focused($editorFocused)
                } footer: {
                    Text("Weather is fetched for Kyiv with a GPS fallback near the city center.")
                }

                Section {
                    if viewModel.isSaving {
                        HStack {
                            ProgressView()
                            Text("Fetching weather…")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("New note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .disabled(viewModel.isSaving)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task { await save() }
                    }
                    .disabled(isSaveDisabled)
                }
            }
            .onAppear { editorFocused = true }
            .alert("Couldn't save note", isPresented: alertBinding, actions: {
                Button("OK", role: .cancel) {
                    viewModel.clearAlert()
                }
            }, message: {
                Text(viewModel.alertMessage ?? "")
            })
        }
    }

    private var alertBinding: Binding<Bool> {
        Binding(
            get: { viewModel.alertMessage != nil },
            set: { isPresented in
                if !isPresented { viewModel.clearAlert() }
            }
        )
    }

    private var isSaveDisabled: Bool {
        noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isSaving
    }

    private func save() async {
        let success = await viewModel.save(noteText: noteText)
        if success {
            onSaved()
            dismiss()
        }
    }
}
