//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import CoreLocation

protocol LocationUpdatesProtocol: AnyObject {
    func didUpdateLocation(currentLocation: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    weak var locationUpdatesDelegate: LocationUpdatesProtocol?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    private static var sharedManager: LocationManager = {
        return LocationManager()
    }()
    
    class func shared() -> LocationManager {
        return sharedManager
    }
    
    func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        locationManager.stopUpdatingLocation()
        self.locationUpdatesDelegate?.didUpdateLocation(currentLocation: currentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedWhenInUse:
                startUpdatingLocation()
            case .authorizedAlways:
                startUpdatingLocation()
            default:
                break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed with error: \(error.localizedDescription)")
    }
}
