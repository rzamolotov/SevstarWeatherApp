//
//  WeatherViewModel.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 22.04.2023.
//

import Foundation

struct WeatherModel {
    
    let cityName: String
    
    let conditionID: Int
    let conditionDescription: String
    
    let temperature: Double
    let maxTemp: Int
    let minTemp: Int
    let fellsLike: Int
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "sun.dust"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}

