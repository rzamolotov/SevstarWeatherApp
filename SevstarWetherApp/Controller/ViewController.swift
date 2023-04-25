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
    private let locationManager = CLLocationManager()
    private let headerView = HeaderView()
    private let currentWeatherView = CurrenWeatherStackView()
    private let forecastViewCell = ForecastViewCell()
    
    
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
        view.addSubview(forecastViewCell)
        
        setupConstrains()
        
    }
    func  setupConstrains() {
        NSLayoutConstraint.activate([
            //header
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: screenHeight * 0.015),
            //currentWeatherView
            currentWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenHeight * 0.01),
            currentWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(screenHeight * 0.01)),
            currentWeatherView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: screenHeight * 0.07),
            currentWeatherView.bottomAnchor.constraint(equalTo: currentWeatherView.bottomAnchor),
            //forecastViewCell
            forecastViewCell.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: screenHeight * 0.3),
            forecastViewCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenHeight * 0.01),
            forecastViewCell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(screenHeight * 0.01)),
        ])
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: [WeatherModel.Hourly]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:00"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        DispatchQueue.main.async {
            self.forecastViewCell.dateLabel.text = dateString
            self.forecastViewCell.weatherSymbol.image = UIImage(systemName: hourlyForecast[0].conditionName)
            self.forecastViewCell.tempLabel.text = "\(hourlyForecast[0].temp) °C"
            
        }
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Сегодня EEEE, dd.MM.yyyy"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        DispatchQueue.main.async {
            self.currentWeatherView.temperatureLabel.text = "\(weather.temperatureString) °C"
            self.currentWeatherView.weatherSymbol.image = UIImage(systemName: weather.conditionName)
            self.headerView.headingLabel.text = weather.cityName
            self.currentWeatherView.currentTime.text = dateString
            self.currentWeatherView.feelsLikeDegrees.text = "Ощущается как \(String(weather.fellsLike))°C"
            
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
