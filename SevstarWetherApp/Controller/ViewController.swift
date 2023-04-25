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
    private let forecatsContainerView = ForecastContainerView()
    private let tableView = UITableView()
    private let detailVC = DetailViewController()
    var hourlyForecast: [WeatherModel.Hourly] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization() // запрашиваем разрешение на получение геоданных
        locationManager.requestLocation() // запрашиваем геоданные пользователя единоразово
        navigationController?.navigationBar.isHidden = true
        tableView.register(ForecastViewCell.self, forCellReuseIdentifier: "ForecastCell")
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(currentWeatherView)
        view.addSubview(forecatsContainerView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDetail))
        currentWeatherView.addGestureRecognizer(tapGesture)
        setupConstrains()
    }
    
    @objc private func didTapDetail() {
        detailVC.modalPresentationStyle = .formSheet
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func  setupConstrains() {
        
        NSLayoutConstraint.activate([
            //headerView
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight * 0.08),
            //currentWeatherView
            currentWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenHeight * 0.01),
            currentWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(screenHeight * 0.01)),
            currentWeatherView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: screenHeight * 0.07),
            currentWeatherView.bottomAnchor.constraint(equalTo: currentWeatherView.bottomAnchor),
            //forecastViewCell
            forecatsContainerView.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: screenHeight * 0.4),
            forecatsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenHeight * 0.01),
            forecatsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(screenHeight * 0.01)),
        ])
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: [WeatherModel.Hourly]) {
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
            weatherManager.fetchHourlyForecast(latitude: lat, longitude: lon)
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
        let hourly = hourlyForecast[indexPath.row]
        cell.dateLabel.text = hourly.dateString
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


