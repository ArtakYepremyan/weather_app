//
//  City.swift
//  WeatherTest
//
//  Created by Admin on 4/19/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import Foundation

struct City {
    let weatherType: String
    let temp: String
    let name: String
    init(from response: CityResponse) {
        weatherType = response.weather[0].main
        temp = "\(Int(response.main.temp - 273.15))°C"
        name = response.name
    }
}
struct CityResponse : Codable {
    let weather: [WeatherData]
    let main: MainData
    let name : String
}

struct WeatherData : Codable {
   let main: String
}

struct MainData : Codable {
    let temp : Double
}


