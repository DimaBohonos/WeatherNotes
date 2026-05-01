//
//  NoteRowView.swift
//  WeatherNotes
//

import SwiftUI

struct NoteRowView: View {
    let item: NoteSummary

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.body)
                    .font(.body)
                    .lineLimit(2)
                    .foregroundStyle(.primary)
                Text(item.createdAt.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 8)
            HStack(spacing: 6) {
                Image(systemName: WeatherSymbolMapper.sfSymbol(forOpenWeatherIcon: item.iconCode))
                    .foregroundStyle(.tint)
                Text(Self.temperature(item.temperatureCelsius))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.primary)
            }
        }
        .accessibilityElement(children: .combine)
    }

    private static func temperature(_ value: Double) -> String {
        String(format: "%.0f°", value)
    }
}
