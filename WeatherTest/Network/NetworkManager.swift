//
//  File.swift
//  WeatherTest
//
//  Created by Admin on 4/19/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

}

extension URL {
    func addQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        var queryItems = components?.queryItems ?? []
        queryItems += queries.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        components?.queryItems = queryItems
        return components?.url
    }
}

extension URLRequest {
    mutating func setUpHeaders() {
        addValue(apiKey, forHTTPHeaderField: "X-API-Key")
    }
}
