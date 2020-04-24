//
//  File.swift
//  WeatherTest
//
//  Created by Admin on 4/19/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import Foundation


private let apiKey = "35be6aa779b97d29025f9c6d854f50eb"
private let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
private enum Key {
    static let apiKey = "appid"
    static let term = "q"
}
class NetworkManager {
    static let shared = NetworkManager()
    
    func getWeatherData(for city: String = "london", complition: @escaping (City?) -> Void) {
        if let url = baseUrl.addQueries([Key.apiKey: apiKey, Key.term: city]) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let result = try? decoder.decode(CityResponse.self, from: data) {
                        complition(City(from: result))
                    } else {
                        complition(nil)
                    }
                    
                }
            }
            task.resume()
        }
    }
}

private extension URL {
    func addQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        var queryItems = components?.queryItems ?? []
        queryItems += queries.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        components?.queryItems = queryItems
        return components?.url
    }
}
