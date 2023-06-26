//
//  CityWeatherPresenter.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation

protocol CityWeatherView: AnyObject {
    func getCurrentState() -> WeatherDetailsState?
    func renderView(state: WeatherDetailsState)
    func showDataNotFoundView()
}

struct WeatherDetailsState {
    var weatherData: WeatherData?
    var forecastData: [ForecastData] = []
}

struct ForecastData {
    var day: String
    var weatherIcon: String
    var highLowTemperature: String
}

class CityWeatherPresenter {
    var cityWeatherView: CityWeatherView?
    var weatherData: WeatherData = WeatherData()
    var weatherDetailsState: WeatherDetailsState?
    
    init(view: CityWeatherView, weatherData: WeatherData) {
        self.cityWeatherView = view
        self.weatherData = weatherData
        fetchWeatherForecast()
    }
    
    func fetchWeatherForecast() {
        guard let latitude = weatherData.latitude,
              let logitude = weatherData.longitude else {
            return
        }
        
        WeatherNetworkService.fetchWeatherForecast(latitude: latitude, longitude: logitude) { forecastResponse, error in
            guard let view = self.cityWeatherView else {
                return
            }
            if let _ = error {
                DispatchQueue.main.async {
                    view.showDataNotFoundView()
                }
                return
            }
            if let forecastResponse = forecastResponse {
                self.setupWeatherForecastData(forecastResponse: forecastResponse)
            }
        }
    }
    
    func setupWeatherForecastData(forecastResponse: ForecastModel) {
        guard let view = cityWeatherView else {
            return
        }
        
        var state = WeatherDetailsState()
        
        let firstFiveDaysForecast = forecastResponse.daily.prefix(5) //Getting first five days from the response
        
        firstFiveDaysForecast.forEach { dailyForecast in
            let day = getDay(dateInPosix: dailyForecast.dt)
            let weatherIcon = dailyForecast.weather.first?.icon ?? ""
            let highLowTemperature = "H:\(String(format: "%.0f", dailyForecast.temp.tempMax - kelvinToCelsius))° L:\(String(format: "%.0f", dailyForecast.temp.tempMin - kelvinToCelsius))°"
            state.forecastData.append(ForecastData(day: day, weatherIcon: weatherIcon, highLowTemperature: highLowTemperature))
        }
        
        DispatchQueue.main.async {
            if state.forecastData.count > 0 {
                view.renderView(state: state)
            }
        }
    }
    
    func getDay(dateInPosix: Double) -> String {
        let date = Date(timeIntervalSince1970: dateInPosix)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // "EEEE" represents the full weekday name
        
        let today = dateFormatter.string(from: Date())
        let day = dateFormatter.string(from: date)
        if day == today {
            return "Today"
        }
        return day
    }
}
