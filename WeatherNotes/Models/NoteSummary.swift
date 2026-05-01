//
//  NoteSummary.swift
//  WeatherNotes
//

import CoreData
import Foundation

struct NoteSummary: Identifiable, Hashable, Sendable {
    let id: UUID
    let body: String
    let createdAt: Date
    let temperatureCelsius: Double
    let iconCode: String
}

extension NoteSummary {
    init(managed note: Note) {
        id = note.noteID ?? UUID()
        body = note.body ?? ""
        createdAt = note.createdAt ?? .distantPast
        temperatureCelsius = note.temperatureCelsius
        iconCode = note.iconCode ?? "02d"
    }
}
