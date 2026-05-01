//
//  WeatherSymbolMapper.swift
//  WeatherNotes
//

import Foundation

enum WeatherSymbolMapper {
    /// Maps OpenWeather icon codes (e.g. "01d", "03n") to SF Symbol names.
    static func sfSymbol(forOpenWeatherIcon code: String) -> String {
        let prefix = code.prefix(2)
        let isNight = code.hasSuffix("n")
        switch prefix {
        case "01":
            return isNight ? "moon.stars.fill" : "sun.max.fill"
        case "02":
            return isNight ? "cloud.moon.fill" : "cloud.sun.fill"
        case "03":
            return "cloud.fill"
        case "04":
            return "smoke.fill"
        case "09":
            return "cloud.drizzle.fill"
        case "10":
            return "cloud.rain.fill"
        case "11":
            return "cloud.bolt.rain.fill"
        case "13":
            return "snowflake"
        case "50":
            return "cloud.fog.fill"
        default:
            return isNight ? "moon.fill" : "sun.max.fill"
        }
    }
}
