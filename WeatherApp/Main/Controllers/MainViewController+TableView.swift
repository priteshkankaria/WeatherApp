//
//  MainViewController+TableView.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentState?.weatherData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseIdentifier, for: indexPath) as? CityCell,
              let weatherData = currentState?.weatherData[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configureCityCell(weatherData: weatherData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let weatherData = currentState?.weatherData[safe: indexPath.row] else {
            return
        }
        let cityWeatherViewController = CityWeatherViewController(nibName: CityWeatherViewController.nibName, bundle: nil)
        cityWeatherViewController.weatherData = weatherData
        navigationController?.modalTransitionStyle = .crossDissolve
        cityWeatherViewController.modalPresentationStyle = .popover
        present(cityWeatherViewController, animated: true, completion: nil)
    }
}
