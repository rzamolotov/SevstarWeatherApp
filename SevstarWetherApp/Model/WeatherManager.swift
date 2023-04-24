//
//  WeatherManager.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 21.04.2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didUpdateHourlyForecast(_ weatherManager: WeatherManager, hourlyForecast: [WeatherModel.Hourly])
    func didFailWithError(error: Error)
    
}

struct WeatherManager {
    
    let weatherURL =  "https://api.openweathermap.org/data/2.5/forecast?&appid=aa819990e915321117e0a69863a72ba3&units=metric&lang=RU"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    } // получаем название города для того чтобы добватьб его в урл
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let  urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    } //получаем урл из широты и долготы
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        if let url  = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                } // если ошибка не равна нулю возвращаем функцию и продолжаем работать, если есть ошибка - печатаем ее в консоле
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
                
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let currentDate = Date(timeIntervalSince1970: decodedData.list[0].dt)
            let cityName = decodedData.city.name
            let conditionID = decodedData.list[0].weather[0].id
            let conditionDescription = decodedData.list[0].weather.description
            let temperature = decodedData.list[0].main.temp
            let maxTemp = decodedData.list[0].main.temp_max
            let minTemp = decodedData.list[0].main.temp_min
            let fellsLike = decodedData.list[0].main.feels_like
            
            let weatherModel = WeatherModel(cityName: cityName, conditionID: conditionID, conditionDescription: conditionDescription, currentDate: currentDate, temperature: temperature, maxTemp: Int(maxTemp), minTemp: Int(minTemp), fellsLike: Int(fellsLike))
            
            if let hourlyList = parseHourlyJSON(decodedData.list) {
                self.delegate?.didUpdateHourlyForecast(self, hourlyForecast: hourlyList)
            }
            return weatherModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseHourlyJSON(_ list: [List]) -> [WeatherModel.Hourly]? {
        let hourlyList = list.map { item -> WeatherModel.Hourly in
            let date = Date(timeIntervalSince1970: item.dt)
            let temperature = item.main.temp
            let conditionID = item.weather.first?.id ?? 0
            let description = item.weather.first?.description ?? ""
            return WeatherModel.Hourly(dt: date, temp: Int(temperature), description: description, conditionID: conditionID)
        }
        return hourlyList
    }
    
}
