//
//  WeatherAPIKey.swift
//  WeatherNotes
//

import Foundation

enum WeatherAPIKey {
    static func loadOpenWeatherKey() throws -> String {
        if let fromEnv = ProcessInfo.processInfo.environment["OPENWEATHER_API_KEY"], !fromEnv.isEmpty {
            return fromEnv
        }
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist") else {
            throw WeatherServiceError.missingAPIKey
        }
        guard let plist = NSDictionary(contentsOf: url) as? [String: Any],
              let key = plist["OPENWEATHER_API_KEY"] as? String,
              !key.isEmpty else {
            throw WeatherServiceError.missingAPIKey
        }
        return key
    }
}
