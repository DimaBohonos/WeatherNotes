//
//  OpenWeatherDTO.swift
//  WeatherNotes
//

import Foundation

struct OpenWeatherResponse: Codable, Sendable {
    let coord: Coord?
    let weather: [WeatherItem]
    let main: Main
    let visibility: Int?
    let wind: Wind?
    let name: String

    struct Coord: Codable, Sendable {
        let lon: Double
        let lat: Double
    }

    struct WeatherItem: Codable, Sendable {
        let description: String
        let icon: String
        let main: String
    }

    struct Main: Codable, Sendable {
        let temp: Double
        let feels_like: Double
        let humidity: Int
        let pressure: Int
    }

    struct Wind: Codable, Sendable {
        let speed: Double
    }
}

extension OpenWeatherResponse {
    /// Convenience snapshot shared by persistence/UI layers.
    var snapshot: WeatherSnapshot {
        WeatherSnapshot(
            latitude: coord?.lat ?? 0,
            longitude: coord?.lon ?? 0,
            locationName: name,
            description: weather.first?.description ?? "",
            summaryMain: weather.first?.main ?? "",
            iconCode: weather.first?.icon ?? "02d",
            temperatureCelsius: main.temp,
            feelsLikeCelsius: main.feels_like,
            humidityPercent: main.humidity,
            windSpeedMs: wind?.speed,
            visibilityMeters: visibility,
            pressureHpa: main.pressure
        )
    }
}
