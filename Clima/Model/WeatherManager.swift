//
//  WeatherManager.swift
//  Clima
//
//  Created by David on 2019. 12. 19..
//  Copyright © 2019. App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager:Weathermanager ,weather: WeatherModel)
    func didFailWithError(error: Error)
}



//connect between the openweatherapp.org and my app
struct  Weathermanager {
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?appid=6859f3b1cc0b128771c3cbf069be3f96&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude:CLLocationDegrees,longitude: CLLocationDegrees ){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon\(longitude)"
        performRequest(with: urlString)
    }
    
     
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
    
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                      return
                  }
                  
                  if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                  }
            }
            
            task.resume()
            
            
        }
        
    }
    
    //parsing the json format to struct
    func parseJSON(_ weatherData: Data)-> WeatherModel? {
        let decoder = JSONDecoder()
        
            //  print("lefut a parse");
        
        do{
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
           
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

    
    
    
}
