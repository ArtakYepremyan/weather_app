//
//  FavoriteViewController.swift
//  WeatherTest
//
//  Created by Admin on 4/25/20.
//  Copyright © 2020 Artak. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var favoriteCitys : [City] = []
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.dataSource = self
        tableVIew.delegate = self
    }
}

extension FavoriteViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteCitys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
}
