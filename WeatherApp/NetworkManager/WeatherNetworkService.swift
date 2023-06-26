//
//  WeatherNetworkService.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation

class WeatherNetworkService: WeatherNetworkProtocol {
    static func fetchWeatherBy(place: String, completion: @escaping (WeatherModelResponse) -> ()) {
        let formattedPlace = place.replacingOccurrences(of: " ", with: "+")
        let URLString = "http://api.openweathermap.org/data/2.5/weather?q=\(formattedPlace)&appid=\(APIKEY1)"
        
        guard let url = URL(string: URLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let currentWeather = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion((currentWeather, nil))
            } catch {
                completion((nil, error))
            }
        }.resume()
    }
    
    static func fetchWeatherBy(latitude: String, longitude: String, completion: @escaping (WeatherModelResponse) -> ()) {
        let URLString = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIKEY1)"

        guard let url = URL(string: URLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let currentWeather = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion((currentWeather, nil))
            } catch {
                completion((nil, error))
            }
        }.resume()
    }
    
    static func fetchWeatherForecast(latitude: String, longitude: String, completion: @escaping (ForecastModelResponse) -> ()) {
        let URLString = "http://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(APIKEY2)"
        
        guard let url = URL(string: URLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let forecastWeather = try JSONDecoder().decode(ForecastModel.self, from: data)
                completion((forecastWeather, nil))
            } catch {
                completion((nil, error))
            }
        }.resume()
    }
}
