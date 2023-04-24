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
        let view = HeaderView()
        return view
    }()
    private lazy var currentWeatherView: CurrenWeatherStackView = {
        let view = CurrenWeatherStackView()
        return view
    }()
    private lazy var hourlyCollectionViewCell: HourlyCollectionViewCell = {
        let view = HourlyCollectionViewCell()
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
        view.addSubview(hourlyCollectionViewCell)
        
        setupConstrains()
        
    }
    func  setupConstrains() {
        
        NSLayoutConstraint.activate([
            //header
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            //currentWeatherView
            currentWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            currentWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            currentWeatherView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 30),
            currentWeatherView.bottomAnchor.constraint(equalTo: currentWeatherView.bottomAnchor),
            //hourlyCollectionView
            hourlyCollectionViewCell.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: 10),
            hourlyCollectionViewCell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hourlyCollectionViewCell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
        ])
    }
    
}




//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: [WeatherModel.Hourly]) {
     
        DispatchQueue.main.async {
            self.hourlyCollectionViewCell.weatherSymbol.image = UIImage(systemName: hourlyForecast[0].conditionName)
           
        }
    }
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd.MM.yyyy"
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

