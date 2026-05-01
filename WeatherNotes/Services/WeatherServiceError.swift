//
//  WeatherServiceError.swift
//  WeatherNotes
//

import Foundation

enum WeatherServiceError: LocalizedError, Equatable {
    case missingAPIKey
    case invalidURL
    case invalidResponse
    case httpStatus(code: Int)
    case decodingFailed
    case noNetwork

    var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            return "OpenWeather API key is missing. Add Secrets.plist with OPENWEATHER_API_KEY."
        case .invalidURL:
            return "Could not build weather request URL."
        case .invalidResponse:
            return "Unexpected response from the weather service."
        case .httpStatus(let code):
            return "Weather service returned status code \(code)."
        case .decodingFailed:
            return "Could not read weather data."
        case .noNetwork:
            return "No internet connection."
        }
    }
}
