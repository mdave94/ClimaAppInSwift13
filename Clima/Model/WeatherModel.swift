//
//  WeatherModel.swift
//  Clima
//
//  Created by David on 2019. 12. 22..
//  Copyright © 2019. App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    
    var temperatureString: String {
        return String(format:"%f0.1",temperature)
        
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
           return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...621:
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
