//
//  WetherData.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 21.04.2023.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let city: CityName
    let list: [List]
}

struct List: Codable {
    let dt: Date
    let main: [Main]
    let weather: [Weather]
}

struct Main: Codable {
    let temp, feels_like, temp_min, temp_max: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}

struct CityName: Codable {
    let name: String
}
