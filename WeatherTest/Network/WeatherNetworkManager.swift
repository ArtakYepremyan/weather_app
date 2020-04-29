//
//  WeatherNetworkManager.swift
//  WeatherTest
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import Foundation

let apiKey = "35be6aa779b97d29025f9c6d854f50eb"
let baseUrl =  "https://api.openweathermap.org/data/2.5"
private let weatherUrl = baseUrl + "/weather"
enum Key {
    static let apiKey = "appid"
    static let term = "q"
}

extension NetworkManager {
    
    func getWeatherData(for city: String = "london", complition: @escaping (City?) -> Void) {
        if let url = URL(string: weatherUrl)?.addQueries([Key.apiKey: apiKey, Key.term: city]) {
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
