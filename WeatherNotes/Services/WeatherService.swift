//
//  WeatherService.swift
//  WeatherNotes
//

import Foundation

protocol WeatherServicing: Sendable {
    func fetchCurrentWeather(city query: String) async throws -> WeatherSnapshot
    func fetchCurrentWeather(latitude: Double, longitude: Double) async throws -> WeatherSnapshot
}

final class WeatherService: WeatherServicing {
    private let session: URLSession
    private let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather")!

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchCurrentWeather(city query: String) async throws -> WeatherSnapshot {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "q", value: encoded),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "en"),
            URLQueryItem(name: "appid", value: try WeatherAPIKey.loadOpenWeatherKey())
        ]
        guard let url = components.url else { throw WeatherServiceError.invalidURL }
        return try await performRequest(url: url)
    }

    func fetchCurrentWeather(latitude: Double, longitude: Double) async throws -> WeatherSnapshot {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "en"),
            URLQueryItem(name: "appid", value: try WeatherAPIKey.loadOpenWeatherKey())
        ]
        guard let url = components.url else { throw WeatherServiceError.invalidURL }
        return try await performRequest(url: url)
    }

    private func performRequest(url: URL) async throws -> WeatherSnapshot {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 25)

        do {
            let (data, response) = try await session.data(for: request)
            guard let http = response as? HTTPURLResponse else {
                throw WeatherServiceError.invalidResponse
            }
            guard (200 ..< 300).contains(http.statusCode) else {
                throw WeatherServiceError.httpStatus(code: http.statusCode)
            }
            let decoded = try JSONDecoder().decode(OpenWeatherResponse.self, from: data)
            return decoded.snapshot
        } catch let error as WeatherServiceError {
            throw error
        } catch let urlError as URLError
            where urlError.code == .notConnectedToInternet || urlError.code == .timedOut || urlError.code == .networkConnectionLost {
            throw WeatherServiceError.noNetwork
        } catch is DecodingError {
            throw WeatherServiceError.decodingFailed
        } catch let urlError as URLError {
            throw urlError.localizedDescription.contains("internet") ? WeatherServiceError.noNetwork : WeatherServiceError.invalidResponse
        } catch {
            throw WeatherServiceError.invalidResponse
        }
    }
}
