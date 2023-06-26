//
//  CityCell.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 15
            containerView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        }
    }
    
    @IBOutlet weak var cityNameLabel: UILabel! {
        didSet {
            cityNameLabel.textColor = Colors.textColor
        }
    }
    
    @IBOutlet weak var myLocationLabel: UILabel! {
        didSet {
            myLocationLabel.textColor = Colors.textColor
            myLocationLabel.text = "My Location"
            myLocationLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var weatherLabel: UILabel! {
        didSet {
            weatherLabel.textColor = Colors.textColor
        }
    }
    
    @IBOutlet weak var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.textColor = Colors.textColor
        }
    }
    
    @IBOutlet weak var highLowTemperatureLabel: UILabel! {
        didSet {
            highLowTemperatureLabel.textColor = Colors.textColor
        }
    }
    
    static var reuseIdentifier: String = "CityCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCityCell(weatherData: WeatherData) {
        cityNameLabel.text = weatherData.cityName
        myLocationLabel.isHidden = !weatherData.isToShowMyLocationLabel
        temperatureLabel.text = weatherData.temperature
        weatherLabel.text = weatherData.weather
        highLowTemperatureLabel.text = weatherData.highLowTemperature
    }
}
