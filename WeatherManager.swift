//
//  WeatherManager.swift
//  Clima
//
//  Created by fernando babonoyaba on 11/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherProtocol {
    func updateWeather(_ weather: WeatherModel)
}

struct WeatherManager {
    
    let weather = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=d677d316193669d4e4926bf444bb4722"
    
    let temperature: Double?
    
    var weatherDelegate: WeatherProtocol?
    
    
    func fetchWeather(name: String){
        let locationWeather = "\(weather)&q=\(name)"
        startSession(urlString: locationWeather)
    }
    
    func fetchWeather(latitude: Double, longitude: Double){
        print(latitude)
        print(longitude)
        let locationWeather = "\(weather)&lat=\(latitude)&lon=\(longitude)"
        startSession(urlString: locationWeather)

        
    }
    
    func startSession(urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let newData = data{
                    if let weather = parceJSON(weatherData: newData){
                        weatherDelegate?.updateWeather(weather)
                    }
                   
                }
            }
            task.resume()
        }
    }
    
    func parceJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let name = decodeData.name
            let temp = decodeData.main.temp
            let condition = WeatherModel(cityName: name, conditionId: id, temp: temp)
            print(id)
            print(condition.temperature)
            return condition
           
        } catch {
            print(error)
            return nil
        }
        
        
    }
    
    
    
}
