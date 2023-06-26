//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Pritesh Kankaria on 24/06/23.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    @IBOutlet weak var weatherTitleLabel: UILabel!  {
        didSet {
            weatherTitleLabel.textColor = Colors.textColor
        }
    }
    
    @IBOutlet weak var searchView: UIImageView! {
        didSet {
            searchView.image = UIImage(named: Images.searchIcon)
            searchView.isUserInteractionEnabled = true
            let searchViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.searchPlaceViewTapped))
            searchView.addGestureRecognizer(searchViewTapGesture)
        }
    }
    
    @IBOutlet weak var citiesTableView: UITableView! {
        didSet {
            citiesTableView.delegate = self
            citiesTableView.dataSource = self
            citiesTableView.separatorStyle = .none
            citiesTableView.backgroundColor = .clear
            citiesTableView.register(UINib(nibName: CityCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CityCell.reuseIdentifier)
        }
    }
    
    var presenter: MainPresenter?
    var currentState: WeatherState?
    
    let locationManager = LocationManager()
    var currentLocation: CLLocation? {
        willSet(newCurrentLocation) {
            fetchWeather(currentLocation: newCurrentLocation)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresenter()
        LocationManager.shared().locationUpdatesDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackgroundColor()
    }
}

extension MainViewController {
    func setPresenter() {
        presenter = MainPresenter(view: self)
    }
    
    func setBackgroundColor() {
        self.setGradientBackgroundColor(backgroundColorTop: Colors.backgroundColorTop,
                                        backgroundColorBottom: Colors.backgroundColorBottom)
    }
    
    @objc func searchPlaceViewTapped() {
        self.openAddPlaceAlert()
    }
    
    func openAddPlaceAlert() {
        let alertController = UIAlertController(title: "Search a Place", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Place name"
        }
        let saveAction = UIAlertAction(title: "Add to List", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            guard let placeName = firstTextField.text else { return }
            self.fetchWeather(place: placeName, currentLocation: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func fetchWeather(place: String = "", currentLocation: CLLocation?) {
        if let currentLocation = currentLocation {
            presenter?.fetchWeatherBy(currentLocation: currentLocation)
        } else {
            presenter?.fetchWeatherBy(place: place)
        }
    }
}
