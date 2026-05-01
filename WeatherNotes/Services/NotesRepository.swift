//
//  NotesRepository.swift
//  WeatherNotes
//

import CoreData
import Foundation

struct NotesRepository {
    func insert(
        noteBody: String,
        createdAt: Date,
        weather: WeatherSnapshot,
        into context: NSManagedObjectContext
    ) throws {
        let trimmed = noteBody.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            throw NSError(domain: "NotesRepository", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Note text cannot be empty."
            ])
        }

        let note = Note(context: context)
        note.noteID = UUID()
        note.body = trimmed
        note.createdAt = createdAt
        note.latitude = weather.latitude
        note.longitude = weather.longitude
        note.locationName = weather.locationName
        note.weatherDescriptionText = weather.description
        note.weatherSummaryMain = weather.summaryMain
        note.iconCode = weather.iconCode
        note.temperatureCelsius = weather.temperatureCelsius
        note.feelsLikeCelsius = weather.feelsLikeCelsius
        note.humidityPercent = Int32(weather.humidityPercent)
        note.windSpeedMs = weather.windSpeedMs ?? 0

        if let visibility = weather.visibilityMeters {
            note.visibilityMeters = Int32(clamping: visibility)
        } else {
            note.visibilityMeters = 0
        }

        if let pressure = weather.pressureHpa {
            note.pressureHpa = Int32(clamping: pressure)
        } else {
            note.pressureHpa = 0
        }

        try context.save()
    }
}
