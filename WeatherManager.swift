//
//  WeatherManager.swift
//  Clima
//
//  Created by fernando babonoyaba on 11/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    let weather = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=d677d316193669d4e4926bf444bb4722"
    
    let temperature: Double?
    
    func fetchWeather(name: String){
        let locationWeather = "\(weather)&q=\(name)"
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
                    parceJSON(weatherData: newData)
                }
            }
            task.resume()
        }
    }
    
    func parceJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            print(id)
            print(getConditionName(weatherId: id))
        } catch {
            print(error)
        }
        
        
    }
    
    func getConditionName(weatherId: Int) -> String {
        
//        switch weather {
//            case 
//        }
        return "i dont have that number in the system"
        
    }
    
}
