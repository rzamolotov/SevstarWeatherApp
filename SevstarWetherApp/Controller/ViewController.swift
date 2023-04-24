//
//  ViewController.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 21.04.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(fontSize: 20)
        return view
    }()
    private lazy var currentWeatherView: CurrenWeatherStackView = {
        let view = CurrenWeatherStackView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // запрашиваем разрешение на получение геоданных
        locationManager.requestLocation() // запрашиваем геоданные пользователя единоразово
        
        weatherManager.delegate = self
        
        setupView()
        
    }
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(currentWeatherView)

        setupConstrains()
        
    }
    func  setupConstrains() {
        //header
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
        //view
        NSLayoutConstraint.activate([
            currentWeatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWeatherView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentWeatherView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 50)
        ])
    }
    
}




//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
       
        DispatchQueue.main.async {
            self.currentWeatherView.temperatureLabel.text = weather.temperatureString
            self.currentWeatherView.weatherSymbol.image = UIImage(systemName: weather.conditionName)
            self.headerView.headingLabel.text = weather.cityName
            self.currentWeatherView.currentTime.text = dateString
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - LocationManager

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

