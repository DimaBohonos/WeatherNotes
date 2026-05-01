//
//  NoteDetailView.swift
//  WeatherNotes
//

import CoreData
import SwiftUI

struct NoteDetailView: View {
    @State private var viewModel: NoteDetailViewModel

    init(noteID: UUID, context: NSManagedObjectContext) {
        _viewModel = State(initialValue: NoteDetailViewModel(noteID: noteID, context: context))
    }

    private var detail: NoteDetail { viewModel.detail }

    var body: some View {
        List {
            Section {
                Text(detail.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } header: {
                Text("Note")
            }

            Section {
                LabeledContent("When") {
                    Text(detail.createdAt.formatted(date: .long, time: .shortened))
                }
                LabeledContent("Location") {
                    Text(detail.locationName)
                }
                if detail.latitude != 0 || detail.longitude != 0 {
                    LabeledContent("Coordinates") {
                        Text("\(formatted(detail.latitude)), \(formatted(detail.longitude))")
                    }
                }
            } header: {
                Text("Context")
            }

            Section {
                HStack(spacing: 14) {
                    Image(systemName: WeatherSymbolMapper.sfSymbol(forOpenWeatherIcon: detail.iconCode))
                        .font(.largeTitle)
                        .foregroundStyle(.tint)
                    VStack(alignment: .leading, spacing: 6) {
                        Text(detail.weatherDescriptionText.capitalized)
                            .font(.title3.weight(.medium))
                        Text(detail.weatherSummaryMain.capitalized)
                            .foregroundStyle(.secondary)
                    }
                }

                LabeledContent("Temperature") {
                    Text(String(format: "%.1f°C", detail.temperatureCelsius))
                }
                LabeledContent("Feels like") {
                    Text(String(format: "%.1f°C", detail.feelsLikeCelsius))
                }
                LabeledContent("Humidity") {
                    Text("\(detail.humidityPercent)%")
                }
                if let wind = detail.windSpeedMs {
                    LabeledContent("Wind") {
                        Text(String(format: "%.1f m/s", wind))
                    }
                }
                if let vis = detail.visibilityMeters {
                    LabeledContent("Visibility") {
                        Text(String(format: "%.1f km", Double(vis) / 1000))
                    }
                }
                if let pressure = detail.pressureHpa {
                    LabeledContent("Pressure") {
                        Text("\(pressure) hPa")
                    }
                }
            } header: {
                Text("Weather")
            }
        }
        .navigationTitle(detail.locationName.isEmpty ? "Weather" : detail.locationName)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formatted(_ coord: Double) -> String {
        String(format: "%.4f", coord)
    }
}
