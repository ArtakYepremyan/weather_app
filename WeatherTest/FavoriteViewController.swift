//
//  FavoriteViewController.swift
//  WeatherTest
//
//  Created by Admin on 4/26/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    var favoriteCityNames : [String] = []
    var favoriteCitys : [City] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getSavedCityNames()
        ViewController.cityClosure = { city in
            var allredyAdded = false
            self.favoriteCityNames.forEach { name in
                if name == city.name {
                    allredyAdded = true
                }
            }
            if !allredyAdded {
                self.favoriteCityNames.append(city.name)
                self.setUpFavoriteCitys()
                self.saveCityNames()
            }
        }
    }
    
    struct Keys {
        static let cityNames = "cityNames"
    }
    
    func getSavedCityNames() {
        guard let names = defaults.object(forKey: Keys.cityNames) as? [String] else {return}
        favoriteCityNames = names
        setUpFavoriteCitys()
    }
    
    func saveCityNames() {
        defaults.set(self.favoriteCityNames, forKey: Keys.cityNames)
    }
    
    func setUpFavoriteCitys() {
        favoriteCityNames.forEach { name in
            NetworkManager.shared.getWeatherData(for: name) { city in
                DispatchQueue.main.async {
                    if let city = city {
                        var allredyAdded = false
                        self.favoriteCitys.forEach { oldCity in
                            if oldCity.name == city.name {
                                allredyAdded = true
                            }
                        }
                        if !allredyAdded {
                        self.favoriteCitys.append(city)
                        self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

extension FavoriteViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteCitys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: FavoriteCityCell.id, for: indexPath) as? FavoriteCityCell else {
            return UITableViewCell()
        }
        cell.setUp(with: favoriteCitys[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
}
