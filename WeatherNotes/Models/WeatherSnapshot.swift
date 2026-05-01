//
//  WeatherSnapshot.swift
//  WeatherNotes
//

import Foundation

struct WeatherSnapshot: Equatable, Sendable {
    var latitude: Double
    var longitude: Double
    var locationName: String
    var description: String
    var summaryMain: String
    var iconCode: String
    var temperatureCelsius: Double
    var feelsLikeCelsius: Double
    var humidityPercent: Int
    var windSpeedMs: Double?
    var visibilityMeters: Int?
    var pressureHpa: Int?
}
