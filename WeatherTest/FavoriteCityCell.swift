//
//  FavoriteCityCell.swift
//  WeatherTest
//
//  Created by Admin on 4/26/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import UIKit

class FavoriteCityCell : UITableViewCell {
    
    static let id = "FavoriteCityCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    func setUp (with city: City) {
        nameLabel.text = city.name
        tempLabel.text = String(city.temp)
        weatherLabel.text = city.weatherType
    }
    
}
