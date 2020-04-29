//
//  DetailViewController.swift
//  WeatherTest
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var city : City?
    var weatherList = [TimeData]()
    var weatherListForSection = [TimeData]() {
        didSet {
             tableView.reloadData()
        }
    }
    let daysDict = [1 : "Sun" , 2 : "Mon", 3 : "Tue", 4 : "Wed", 5 : "Thu", 6 : "Fri", 7 : "Sat", 8 : "Sun", 9 : "Mon", 10 : "Tue", 11 : "Wed", 12 : "Thu"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let city = city {
        setUp(with: city)
        }
    }
    
    @IBAction func segmentControlTapped(_ sender: Any) {
        let segmentIndex = segmentControl.selectedSegmentIndex
        switch segmentIndex {
        case 0:
            weatherListForSection = Array(weatherList[0..<7])
        case 1:
            weatherListForSection = Array(weatherList[8..<15])
        case 2:
            weatherListForSection = Array(weatherList[16..<23])
        case 3:
            weatherListForSection = Array(weatherList[24..<31])
        case 4:
            weatherListForSection = Array(weatherList[32..<39])
        default:
            return
        }
    }
    
    func setUp(with city: City) {
        title = city.name
        cityName.text = city.name
        cityTemp.text = city.temp
        setDaysOfWeek()
        NetworkManager.shared.getWeatherForecastData(for: city.name.lowercased()) { [weak self] dataList in
                  DispatchQueue.main.async {
                      if let self = self, let dataList = dataList {
                        self.weatherList = dataList
                        self.weatherListForSection = Array(self.weatherList[0..<7])
                      }
                  }
              }
    }
    
    func setDaysOfWeek() {
        guard var dayNumber = Date().dayNumberOfWeek() else {return}
        for c in 0 ... 4 {
            segmentControl.setTitle(daysDict[dayNumber], forSegmentAt: c)
            dayNumber += 1
        }
    }
    
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherListForSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = weatherListForSection[indexPath.row]
        let temp = data.temrature
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        let date = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(data.timeStamp)))
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(temp) \(data.weather) \(date)"
        return cell
    }
    
    
}

private extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

struct TimeData {
    let timeStamp: Int
    let weather: String
    let temrature: String
}
