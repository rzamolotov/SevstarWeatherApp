//
//  DetailViewController.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 25.04.2023.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {
    private let currentWeatherDetailView = CurrentWeatherDetailView()
    var weatherModel: WeatherModel?
    var weatherManager = WeatherManager()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // запрашиваем разрешение на получение геоданных
        locationManager.requestLocation() // запрашиваем геоданные пользователя единоразово
        weatherManager.delegate = self
        setupView()
        view.backgroundColor = .white
      
    }
    func setupView() {
        view.addSubview(currentWeatherDetailView)
        setupConstrains()
    }
    
    func  setupConstrains() {
        NSLayoutConstraint.activate([
            //currentWeatherView
            currentWeatherDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentWeatherDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentWeatherDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            currentWeatherDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }
}
//MARK: - WeatherManagerDelegate

extension DetailViewController: WeatherManagerDelegate {
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: [WeatherModel.Hourly]) {
        
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Сегодня EEEE, dd.MM.yyyy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        DispatchQueue.main.async {
            self.currentWeatherDetailView.temperatureLabel.text = "\(weather.temperatureString) °C"
            self.currentWeatherDetailView.weatherSymbol.image = UIImage(systemName: weather.conditionName)
            self.currentWeatherDetailView.currentTime.text = dateString
            self.currentWeatherDetailView.feelsLikeDegrees.text = "Ощущается как \(String(weather.fellsLike))°C"
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - LocationManager

extension DetailViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            weatherManager.fetchHourlyForecast(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
