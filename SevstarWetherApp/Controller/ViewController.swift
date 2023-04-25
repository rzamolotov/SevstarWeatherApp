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
    private let forecatsContainerView = ForecastContainerView()
    private let tableView = UITableView()
    var hourlyForecast: [WeatherModel.Hourly] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // запрашиваем разрешение на получение геоданных
        locationManager.requestLocation() // запрашиваем геоданные пользователя единоразово
        weatherManager.delegate = self
        
        
        setupView()
        setupTableView()
        
    }
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ForecastViewCell.self, forCellReuseIdentifier: "ForecastCell")
        view.addSubview(tableView)
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(currentWeatherView)
        view.addSubview(forecatsContainerView)
        
        setupConstrains()
        
    }
    func  setupConstrains() {
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(headerView)
        containerView.addSubview(currentWeatherView)
        containerView.addSubview(forecatsContainerView)

        NSLayoutConstraint.activate([
            //containerView
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //headerView
            headerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenHeight * 0.015),
            //currentWeatherView
            currentWeatherView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: screenHeight * 0.01),
            currentWeatherView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -(screenHeight * 0.01)),
            currentWeatherView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: screenHeight * 0.07),
            currentWeatherView.bottomAnchor.constraint(equalTo: currentWeatherView.bottomAnchor),
            //forecastViewCell
            forecatsContainerView.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: screenHeight * 0.4),
            forecatsContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: screenHeight * 0.01),
            forecatsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -(screenHeight * 0.01)),
        ])
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: [WeatherModel.Hourly]) {
        forecastViewCell.hourlyForecast = hourlyForecast
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
//MARK: - TableViewDelegate

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:00"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        let hourly = hourlyForecast[indexPath.row]
        cell.dateLabel.text = dateString
        cell.weatherSymbol.image = UIImage(systemName: hourly.conditionName)
        cell.tempLabel.text = "\(hourly.temp) °C"
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenHeight * 0.07
    }
}


