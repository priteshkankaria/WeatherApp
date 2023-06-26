//
//  CityWeatherViewController.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 25/06/23.
//

import UIKit

class CityWeatherViewController: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel! {
        didSet {
            cityNameLabel.textColor = Colors.textColor
        }
    }
    
    @IBOutlet weak var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.textColor = Colors.textColor
        }
    }
    
    @IBOutlet weak var weatherLabel: UILabel! {
        didSet {
            weatherLabel.textColor = Colors.textColor
        }
    }
    
    @IBOutlet weak var highLowTemperatureLabel: UILabel! {
        didSet {
            highLowTemperatureLabel.textColor = Colors.textColor
        }
    }
    
    @IBOutlet weak var forecastTitleLabel: UILabel! {
        didSet {
            forecastTitleLabel.textColor = Colors.textColor
            forecastTitleLabel.text = "Upcoming Forecast"
        }
    }
    
    @IBOutlet weak var forecastTableView: UITableView! {
        didSet {
            forecastTableView.delegate = self
            forecastTableView.dataSource = self
            forecastTableView.separatorStyle = .none
            forecastTableView.backgroundColor = .clear
            forecastTableView.register(UINib(nibName: ForecastCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ForecastCell.reuseIdentifier)
        }
    }
    
    @IBOutlet weak var dataNotAvailableView: UIView! {
        didSet {
            dataNotAvailableView.layer.cornerRadius = 20
            dataNotAvailableView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            dataNotAvailableView.isHidden = true
        }
    }
    
    @IBOutlet weak var forecastDataNotAvailableLabel: UILabel! {
        didSet {
            forecastDataNotAvailableLabel.textColor = Colors.textColor
            forecastDataNotAvailableLabel.text = "Forecast Data not Available"
        }
    }
    
    
    static var nibName: String = "CityWeather"
    
    var presenter: CityWeatherPresenter?
    var weatherData: WeatherData = WeatherData()
    var currentState: WeatherDetailsState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresenter()
        setInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackgroundColor()
    }
}

extension CityWeatherViewController {
    func setBackgroundColor() {
        self.setGradientBackgroundColor(backgroundColorTop: Colors.backgroundColorTop,
                                        backgroundColorBottom: Colors.backgroundColorBottom)
    }
    
    func setPresenter() {
        presenter = CityWeatherPresenter(view: self, weatherData: weatherData)
    }
    
    func setInitialData() {
        cityNameLabel.text = weatherData.cityName
        temperatureLabel.text = weatherData.temperature
        weatherLabel.text = weatherData.weather
        highLowTemperatureLabel.text = weatherData.highLowTemperature
    }
}
