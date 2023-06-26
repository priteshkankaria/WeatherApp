//
//  CityWeatherViewController+CityWeatherView.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation

extension CityWeatherViewController: CityWeatherView {
    func getCurrentState() -> WeatherDetailsState? {
        currentState
    }
    
    func renderView(state: WeatherDetailsState) {
        currentState = state
        hideDataNotFoundView()
        forecastTableView.reloadData()
    }
    
    func showDataNotFoundView() {
        forecastTableView.isHidden = true
        dataNotAvailableView.isHidden = false
    }
    
    func hideDataNotFoundView() {
        forecastTableView.isHidden = false
        dataNotAvailableView.isHidden = true
    }
}
