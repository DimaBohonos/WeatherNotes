//
//  NoteDetail.swift
//  WeatherNotes
//

import CoreData
import Foundation

struct NoteDetail: Identifiable, Hashable, Sendable {
    let id: UUID
    let body: String
    let createdAt: Date
    let latitude: Double
    let longitude: Double
    let locationName: String
    let weatherDescriptionText: String
    let weatherSummaryMain: String
    let iconCode: String
    let temperatureCelsius: Double
    let feelsLikeCelsius: Double
    let humidityPercent: Int
    let windSpeedMs: Double?
    let visibilityMeters: Int?
    let pressureHpa: Int?
}

extension NoteDetail {
    init(managed note: Note) {
        id = note.noteID ?? UUID()
        body = note.body ?? ""
        createdAt = note.createdAt ?? .distantPast
        latitude = note.latitude
        longitude = note.longitude
        locationName = note.locationName ?? ""
        weatherDescriptionText = note.weatherDescriptionText ?? ""
        weatherSummaryMain = note.weatherSummaryMain ?? ""
        iconCode = note.iconCode ?? "02d"
        temperatureCelsius = note.temperatureCelsius
        feelsLikeCelsius = note.feelsLikeCelsius
        humidityPercent = Int(note.humidityPercent)
        windSpeedMs = note.windSpeedMs
        visibilityMeters = note.visibilityMeters > 0 ? Int(note.visibilityMeters) : nil
        pressureHpa = note.pressureHpa > 0 ? Int(note.pressureHpa) : nil
    }
}
