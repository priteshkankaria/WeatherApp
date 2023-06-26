//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation

struct WeatherModel: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let main: MainTemperature
    let name: String?
    let timezone: Int?
    let dt_txt: String?
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainTemperature: Codable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}






//
//struct Weather: Codable {
//    let cod: String
//    let message, cnt: Int
//    let list: [List]
//    let city: City
//}
//
//struct City: Codable {
//    let id: Int
//    let name: String
//    let coord: Coord
//    let country: String
//    let population, timezone, sunrise, sunset: Int
//}
//
//struct Coord: Codable {
//    let lat, lon: Double
//}
//
//struct List: Codable {
//    let dt: Int
//    let main: MainClass
//    let weather: [WeatherElement]
//    let clouds: Clouds
//    let wind: Wind
//    let visibility: Int
//    let pop: Double
//    let rain: Rain?
//    let sys: Sys
//    let dtTxt: String
//
//    enum CodingKeys: String, CodingKey {
//        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
//        case dtTxt = "dt_txt"
//    }
//}
//
//struct Clouds: Codable {
//    let all: Int
//}
//
//struct MainClass: Codable {
//    let temp: Double
//    let feelsLike: Double
//    let tempMin: Double
//    let tempMax: Double
//
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//    }
//}
//
//struct Rain: Codable {
//    let the3H: Double
//
//    enum CodingKeys: String, CodingKey {
//        case the3H = "3h"
//    }
//}
//
//struct Sys: Codable {
//    let pod: Pod
//}
//
//enum Pod: String, Codable {
//    case d = "d"
//    case n = "n"
//}
//
//struct WeatherElement: Codable {
//    let id: Int
//    let main: MainEnum
//    let description: Description
//    let icon: Icon
//}
//
//enum Description: String, Codable {
//    case lightRain = "light rain"
//    case overcastClouds = "overcast clouds"
//}
//
//enum Icon: String, Codable {
//    case the04D = "04d"
//    case the04N = "04n"
//    case the10D = "10d"
//    case the10N = "10n"
//}
//
//enum MainEnum: String, Codable {
//    case clouds = "Clouds"
//    case rain = "Rain"
//}
//
//struct Wind: Codable {
//    let speed: Double
//    let deg: Int
//    let gust: Double
//}
