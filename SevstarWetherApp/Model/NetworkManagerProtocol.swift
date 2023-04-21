//
//  NetworkManagerProtocol.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 21.04.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCurrentWeather(city: String, completion: @escaping (WeatherModel) -> ())
    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (WeatherModel) -> ())
    func fetchWeatherForecast(city: String, completion: @escaping ([ForecastTemperature]) -> ())
    
}
