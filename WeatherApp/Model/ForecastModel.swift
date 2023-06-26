//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation

struct ForecastModel: Codable {
    var daily: [DailyForecast]
}

struct DailyForecast: Codable {
    let dt: Double
    let temp: Temperature
    let weather: [Weather]
}

struct Temperature: Codable {
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "min"
        case tempMax = "max"
    }
}
