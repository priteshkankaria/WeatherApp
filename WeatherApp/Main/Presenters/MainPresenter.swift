//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation
import CoreLocation

protocol MainPresenterView: AnyObject {
    func getCurrentState() -> WeatherState?
    func renderView(state: WeatherState)
    func showPlaceNotFoundToast(message: String)
}

struct WeatherState {
    var weatherData: [WeatherData] = []
}

struct WeatherData {
    var latitude: String?
    var longitude: String?
    var cityName: String?
    var isToShowMyLocationLabel: Bool = false
    var temperature: String?
    var weather: String?
    var highLowTemperature: String?
}

class MainPresenter {
    var mainPresenterView: MainPresenterView?
    
    init(view: MainPresenterView) {
        mainPresenterView = view
    }
    
    func fetchWeatherBy(currentLocation: CLLocation?) {
        guard let currentLocation = currentLocation else {
            return
        }
        let latitude = currentLocation.coordinate.latitude.description
        let longitude = currentLocation.coordinate.longitude.description
    
        WeatherNetworkService.fetchWeatherBy(latitude: latitude, longitude: longitude) { weatherResponse, _ in
            if let weatherResponse = weatherResponse {
                self.setupWeatherData(weatherResponse: weatherResponse, isToShowMyLocationLabel: true)
            }
        }
    }
    
    func fetchWeatherBy(place: String) {
        WeatherNetworkService.fetchWeatherBy(place: place) { weatherResponse, error in
            guard let view = self.mainPresenterView else {
                return
            }
            if let _ = error {
                DispatchQueue.main.async {
                    view.showPlaceNotFoundToast(message: "Invalid Location")
                }
                return
            }
            if let weatherResponse = weatherResponse {
                self.setupWeatherData(weatherResponse: weatherResponse, isToShowMyLocationLabel: false)
            }
        }
    }
    
    func setupWeatherData(weatherResponse: WeatherModel, isToShowMyLocationLabel: Bool) {
        guard let view = mainPresenterView else {
            return
        }
        
        var state = view.getCurrentState() ?? WeatherState()

        let latitude = weatherResponse.coord.lat.description
        let longitude = weatherResponse.coord.lon.description
        let cityName = weatherResponse.name ?? ""
        let temperature = " \(String(format: "%.0f", weatherResponse.main.temp - kelvinToCelsius))°"
        let weather = weatherResponse.weather.first?.main ?? ""
        let highLowTemperature = "H:\(String(format: "%.0f", weatherResponse.main.tempMax - kelvinToCelsius))° L:\(String(format: "%.0f", weatherResponse.main.tempMin - kelvinToCelsius))°"
        
        state.weatherData.append(WeatherData(latitude: latitude, longitude: longitude, cityName: cityName, isToShowMyLocationLabel: isToShowMyLocationLabel, temperature: temperature, weather: weather, highLowTemperature: highLowTemperature))
        DispatchQueue.main.async {
            view.renderView(state: state)
        }
    }
}
