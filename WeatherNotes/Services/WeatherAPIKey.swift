//
//  WeatherAPIKey.swift
//  WeatherNotes
//

import Foundation

enum WeatherAPIKey {
    static func loadOpenWeatherKey() throws -> String {
        if let fromEnv = ProcessInfo.processInfo.environment["OPENWEATHER_API_KEY"] {
            let cleaned = cleanedKey(fromEnv)
            if !cleaned.isEmpty {
                return cleaned
            }
        }

        if let fromSecrets = keyFromBundlePlist(named: "Secrets"), !fromSecrets.isEmpty {
            return fromSecrets
        }

        // Dev-friendly fallback: if user edited example file locally.
        if let fromExample = keyFromBundlePlist(named: "Secrets.example"), !fromExample.isEmpty {
            return fromExample
        }

        throw WeatherServiceError.missingAPIKey
    }

    private static func keyFromBundlePlist(named name: String) -> String? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "plist"),
              let plist = NSDictionary(contentsOf: url) as? [String: Any],
              let key = plist["OPENWEATHER_API_KEY"] as? String else {
            return nil
        }
        let cleaned = cleanedKey(key)
        if cleaned.isEmpty || cleaned == "REPLACE_WITH_YOUR_OPENWEATHER_KEY" {
            return nil
        }
        return cleaned
    }

    private static func cleanedKey(_ raw: String) -> String {
        raw.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
