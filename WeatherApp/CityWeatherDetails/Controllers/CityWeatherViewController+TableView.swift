//
//  CityWeatherViewController+TableView.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import UIKit

extension CityWeatherViewController: UITableViewDelegate, UITableViewDataSource   {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentState?.forecastData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.reuseIdentifier, for: indexPath) as? ForecastCell,
              let forecastData = currentState?.forecastData[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configureForecastCell(forecastData: forecastData)
        return cell
    }
}
