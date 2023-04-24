//
//  WetherData.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 21.04.2023.
//

import Foundation

struct WeatherData: Codable {
    let city: CityName
    let list: [List]
}

struct List: Codable {
    let dt: Date
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct CityName: Codable {
    let name: String
}

