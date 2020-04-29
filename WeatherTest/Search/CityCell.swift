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
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    func setUp (with city: City) {
        nameLabel.text = city.name
        tempLabel.text = String(city.temp)
        weatherLabel.text = city.weatherType
    }
    
   
}
