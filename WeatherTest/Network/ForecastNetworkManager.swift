//
//  ForecastNetworkManager.swift
//  WeatherTest
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import Foundation


private let forecastUrl = baseUrl + "/forecast"

extension NetworkManager {
    private struct ForecastResponseData: Codable {
        struct ItemData: Codable {
            let weather: [WeatherData]
            let main: MainData
            let dt: Int
        }
        let list: [ItemData]
    }

    func getWeatherForecastData(for city: String, completion: @escaping ([TimeData]?) -> Void) {
        if let url = URL(string: forecastUrl)?.addQueries([Key.term: city]) {
            var request = URLRequest(url: url)
            request.setUpHeaders()
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data, let response = try? decoder.decode(ForecastResponseData.self, from: data) {
                    completion(response.list.map({ TimeData(timeStamp: $0.dt,
                                                            weather: $0.weather[0].main,
                                                            temrature: "\(Int($0.main.temp - 273.15))°C") }))
                    return
                }
                completion(nil)
            }
            task.resume()
        }
    }
}
