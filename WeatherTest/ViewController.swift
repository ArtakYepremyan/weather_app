//
//  ViewController.swift
//  WeatherTest
//
//  Created by Admin on 4/19/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var city: [City] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButtonOutlet.layer.cornerRadius = searchButtonOutlet.frame.size.height / 2
        tableView.delegate = self
        tableView.dataSource = self
//        NetworkManager.shared.getWeatherData() { city in
//            DispatchQueue.main.async {
//                if let city = city {
//                    self.city.append(city)
//                    self.tableView.reloadData()
//                }
//            }
//        }

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    @IBAction func searchAction(_ sender: Any) {
        guard let text = searchField.text else {return}
        NetworkManager.shared.getWeatherData(for: text) { city in
                   DispatchQueue.main.async {
                       if let city = city {
                           self.city.append(city)
                           self.tableView.reloadData()
                       }
                   }
               }
    }
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: CityCell.id, for: indexPath) as? CityCell else {
            return UITableViewCell()
        }
        cell.setUp(with: city[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
    
    
}

