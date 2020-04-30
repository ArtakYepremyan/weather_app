//
//  TableViewCell.swift
//  WeatherTest
//
//  Created by Admin on 4/19/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import UIKit

class CityCell : UITableViewCell{
    static let id = "CityCell"
    let defaults = UserDefaults.standard
    var favoriteCityNames : [String] = []
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    func getSavedCityNames() {
        guard let names = defaults.object(forKey: Keys.cityNames) as? [String] else {return}
        favoriteCityNames = names
    }
    
    func setButtonState(with cityName: String) {
        var allreadyAdded = false
        favoriteCityNames.forEach { name in
            if name == cityName {
                allreadyAdded = true
                return
            }
        }
        if allreadyAdded {
            saveButton.setImage(UIImage(named: "blackHeartImage"), for: .normal)
        } else {
            saveButton.setImage(UIImage(named: "heartImage"), for: .normal)
        }
    }
    
    func setUp (with city: City) {
        getSavedCityNames()
        setButtonState(with: city.name)
        nameLabel.text = city.name
        tempLabel.text = String(city.temp)
        weatherLabel.text = city.weatherType
    }
    
   
}
