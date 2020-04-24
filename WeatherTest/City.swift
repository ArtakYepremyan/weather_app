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
    let temp: Double
    let name: String
    init(from response: CityResponse) {
        weatherType = response.weather[0].main
        temp = response.main.temp
        name = response.name
        
    }
}

struct CityResponse : Codable {
    let weather: [Weather]
    let main: Main
    let name : String
}

struct Weather : Codable {
   let main: String
}

struct Main : Codable {
    let temp : Double
}


