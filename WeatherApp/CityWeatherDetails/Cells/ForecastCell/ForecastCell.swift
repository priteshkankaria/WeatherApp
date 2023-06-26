//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import UIKit

class ForecastCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 15
            containerView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        }
    }
    
    @IBOutlet weak var dayLabel: UILabel! {
        didSet {
            dayLabel.textColor = Colors.textColor
        }
    }
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var highLowTemperatureLabel: UILabel! {
        didSet {
            highLowTemperatureLabel.textColor = Colors.textColor
        }
    }
    
    static var reuseIdentifier: String = "ForecastCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureForecastCell(forecastData: ForecastData) {
        dayLabel.text = forecastData.day
        weatherIcon.loadImageWith(imageUrlString: "http://openweathermap.org/img/wn/\(forecastData.weatherIcon)@2x.png")
        highLowTemperatureLabel.text = forecastData.highLowTemperature
    }
}
