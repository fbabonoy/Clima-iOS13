//
//  WeatherModel.swift
//  Clima
//
//  Created by fernando babonoyaba on 11/17/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let cityName: String
    let conditionId: Int
    let temp: Double
    
    var temperature: String{
        return String(format: "%.1f", temp)
    }
    
    var conditionname: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
   
    

}
