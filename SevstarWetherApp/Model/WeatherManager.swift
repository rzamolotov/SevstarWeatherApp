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
    
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?appid=aa819990e915321117e0a69863a72ba3&units=metric"
    
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
        //1. создаем a URL
        if let url  = URL(string: urlString) {
            //2. создаем URLSession
            let session = URLSession(configuration: .default)
            //3. Даем сессии задачу
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                } // если ошибка не равна нулю возвращаем функцию и продолжаем работать, если есть ошибка - печатаем ее в консоле, можно сделать алерт
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. продолжаем выполнять задачу
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder() // создаем константу декодирования
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData) //выбираем, что декодировать
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: cityName, temperature: temp) // создаем объект
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error) // если не получается декодировать данные пишем ошибку
            return nil
        }
    }
}
