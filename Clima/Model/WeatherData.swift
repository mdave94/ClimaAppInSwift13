//
//  WeatherData.swift
//  Clima
//
//  Created by David on 2019. 12. 22..
//  Copyright © 2019. App Brewery. All rights reserved.
//

//Decoding JSON format to struct
//

import Foundation


struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable{
    let id: Int
    let description: String
}
