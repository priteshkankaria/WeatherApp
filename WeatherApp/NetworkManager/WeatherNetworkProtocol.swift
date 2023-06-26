//
//  WeatherNetworkProtocol.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation

typealias WeatherModelResponse = (response: WeatherModel?, error: Error?)
typealias ForecastModelResponse = (response: ForecastModel?, error: Error?)

protocol WeatherNetworkProtocol {
    static func fetchWeatherBy(place: String, completion: @escaping (WeatherModelResponse) -> ())
    static func fetchWeatherBy(latitude: String, longitude: String, completion: @escaping (WeatherModelResponse) -> ())
    static func fetchWeatherForecast(latitude: String, longitude: String, completion: @escaping (ForecastModelResponse) -> ())
}
