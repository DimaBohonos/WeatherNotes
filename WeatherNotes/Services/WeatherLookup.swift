//
//  WeatherLookup.swift
//  WeatherNotes
//

import Foundation

/// Default OpenWeather `/weather?q=…` target for snapshots tied to Kyiv unless coordinates are wired later.
enum WeatherLookup {
    static let defaultCityQuery = "Kyiv,UA"
}
