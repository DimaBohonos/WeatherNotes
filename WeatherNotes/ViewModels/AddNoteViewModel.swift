//
//  AddNoteViewModel.swift
//  WeatherNotes
//

import CoreData
import Foundation

@Observable
@MainActor
final class AddNoteViewModel {
    private let context: NSManagedObjectContext
    private let weather: WeatherServicing
    private let repository = NotesRepository()

    private(set) var isSaving = false
    private(set) var alertMessage: String?

    init(context: NSManagedObjectContext, weather: WeatherServicing) {
        self.context = context
        self.weather = weather
    }

    func clearAlert() {
        alertMessage = nil
    }

    func save(noteText: String) async -> Bool {
        let trimmed = noteText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            alertMessage = "Please enter note text."
            return false
        }

        guard !isSaving else { return false }
        isSaving = true
        defer { isSaving = false }

        do {
            let snapshot: WeatherSnapshot
            do {
                snapshot = try await weather.fetchCurrentWeather(city: WeatherLookup.defaultCityQuery)
            } catch {
                snapshot = try await weather.fetchCurrentWeather(latitude: 50.4501, longitude: 30.5234)
            }

            try repository.insert(noteBody: trimmed, createdAt: .now, weather: snapshot, into: context)
            alertMessage = nil
            return true
        } catch let error as LocalizedError {
            alertMessage = error.errorDescription ?? error.localizedDescription
            context.rollback()
            return false
        } catch {
            alertMessage = error.localizedDescription
            context.rollback()
            return false
        }
    }
}
