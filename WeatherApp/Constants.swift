//
//  Constants.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import Foundation
import UIKit

let cachedImages = NSCache<NSString, UIImage>()
let APIKEY1: String = "da4da709971c7d9aab3541aa9bdb1b85"
let APIKEY2: String = "047ef9c3516e552807a6bbd0067851ce" //Taken this key from Internet as my key was not working for second API even though it's activated
let kelvinToCelsius: Double = 273.15


struct Colors {
    static let textColor = UIColor(red: 0.19, green: 0.2, blue: 0.25, alpha: 1)
    static let backgroundColorTop = UIColor(red: 1, green: 0.89, blue: 0.74, alpha: 1).cgColor
    static let backgroundColorBottom = UIColor(red: 0.95, green: 0.6, blue: 0.46, alpha: 1).cgColor
}

struct Images {
    static let searchIcon: String = "search"
}
