//
//  WeatherManager.swift
//  Clima
//
//  Created by MyMacBook on 06.07.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
  func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
  let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=33a0a702be2d799a75858dde041a0dfb&units=metric"
  
  var delegate: WeatherManagerDelegate?
  
  func fetchWeather(cityName: String) {
    let urlString = "\(weatherURL)&q=\(cityName)"
    
    performRequest(urlString: urlString)
  }
  
  func performRequest(urlString: String) {
    //1. Create a URL
    
    if let url = URL(string: urlString) {
      //2. Create a URLSession
      
      let session = URLSession(configuration: .default)
      
      //3. Give the session a task
      
      let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          print(error!)
          return
        }
        
        if let safeData = data {
          if let weather = self.parseJSON(weatherData: safeData) {
            self.delegate?.didUpdateWeather(weather: weather)
          }
        }
      }
      
      //4. Start the task
      task.resume()
    }
    
  }
  
  func parseJSON(weatherData: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
      let id = decodedData.weather[0].id
      let temp = decodedData.main.temp
      let name = decodedData.name
      
      let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
      return weather
      
      print(weather.temperatureString)
    } catch {
      print(error)
      return nil
    }
  }
  
}