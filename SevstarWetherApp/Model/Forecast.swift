//
//  Forecast.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 21.04.2023.
//

import UIKit

struct WeatherInfo {
    let temp: Float
    let min_temp: Float
    let max_temp: Float
    let description: String
    let icon: String
    let time: String
}

struct ForecastTemperature {
    let weekDay: String?
    let hourlyForecast: [WeatherInfo]?
}
