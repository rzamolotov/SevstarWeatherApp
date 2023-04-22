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
        NSLayoutConstraint.activate([
            currentWeatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWeatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            currentWeatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}




//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.currentWeatherView.temperatureLabel.text = weather.temperatureString
            self.currentWeatherView.weatherSymbol.image = UIImage(systemName: weather.conditionName)
            self.headerView.headingLabel.text = weather.cityName
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

