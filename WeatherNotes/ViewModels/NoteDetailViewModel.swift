//
//  NoteDetailViewModel.swift
//  WeatherNotes
//

import CoreData
import Foundation

@Observable
@MainActor
final class NoteDetailViewModel {
    let detail: NoteDetail

    init(noteID: UUID, context: NSManagedObjectContext) {
        let request = Note.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "noteID == %@", noteID as CVarArg)
        if let note = try? context.fetch(request).first {
            detail = NoteDetail(managed: note)
        } else {
            detail = NoteDetail(
                id: noteID,
                body: "",
                createdAt: .distantPast,
                latitude: 0,
                longitude: 0,
                locationName: "",
                weatherDescriptionText: "",
                weatherSummaryMain: "",
                iconCode: "02d",
                temperatureCelsius: 0,
                feelsLikeCelsius: 0,
                humidityPercent: 0,
                windSpeedMs: nil,
                visibilityMeters: nil,
                pressureHpa: nil
            )
        }
    }
}
