//
//  FavoritesViewController.swift
//  City2City729
//
//  Created by mac on 8/6/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class RecentsViewController: UIViewController {
    
    @IBOutlet weak var recentsTableView: UITableView!
    
    var cities = [City]() {
        didSet {
            
            recentsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecents()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cities = manager.load()
        
    }
    
    private func setupRecents() {
        
        recentsTableView.register(UINib(nibName: CityTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CityTableCell.identifier)
        recentsTableView.tableFooterView = UIView(frame: .zero)

    }


}

extension RecentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //limit cities array size to be displayed to 10
        return cities.count > 10 ? 10 : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as! CityTableCell
        
        
        //reverse the order of the cities array
        let reversedCities : [City] = cities.reversed()
        
        //retain the 10 most recent cities that were displayed and do not retain the 11th
        var fifoCities : [City] = cities.count > 10 ? Array(reversedCities.prefix(10)) : reversedCities
        
        let city = fifoCities[indexPath.row]
        
        cell.city = city
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        goToMap(of: city)
    }
    
    
}
