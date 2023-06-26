//
//  MainViewController+LocationUpdatesProtocol.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import CoreLocation

extension MainViewController: LocationUpdatesProtocol {
    func didUpdateLocation(currentLocation: CLLocation) {
        print(currentLocation)
        self.currentLocation = currentLocation
    }
}
