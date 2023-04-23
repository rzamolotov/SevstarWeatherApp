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
            let cityName = decodedData.city.name
            
            guard let weather = decodedData.list.first?.weather.first else {
                return nil // обработка случая, когда массивы list или weather пустые
            }
            
            let conditionID = weather.id
            let conditionDescription = weather.description
            
            guard let main = decodedData.list.first?.main else {
                return nil // обработка случая, когда массив main пустой
            }
            
            let temperature = decodedData.list[0].main[0].temp
            let maxTemp = decodedData.list[0].main[0].temp_max
            let minTemp = decodedData.list[0].main[0].temp_min
            let fellsLike = decodedData.list[0].main[0].feels_like
            
            let weatherModel = WeatherModel(cityName: cityName, conditionID: conditionID, conditionDescription: conditionDescription, temperature: temperature, maxTemp: Int(maxTemp), minTemp: Int(minTemp), fellsLike: Int(fellsLike))
            return weatherModel
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
