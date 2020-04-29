//
//  Converter.swift
//  WeatherTest
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import Foundation

struct TempConverter {

    func kelvinToCelsius(kelvin: Double) -> Double {
        return kelvin - 273.15
    }

}
