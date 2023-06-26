//
//  MainViewController+MainPresenterView.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation

extension MainViewController: MainPresenterView {
    func getCurrentState() -> WeatherState? {
        currentState
    }
    
    func renderView(state: WeatherState) {
        currentState = state
        citiesTableView.reloadData()
    }
    
    func showPlaceNotFoundToast(message: String) {
        self.showToast(message: message)
    }
}
