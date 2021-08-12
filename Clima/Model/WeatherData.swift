//
//  WeatherData.swift
//  Clima
//
//  Created by MyMacBook on 15.07.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
  let name: String
  let main: Main
//  let list: [List]
  let weather: [Weather]
}

struct Main: Codable {
  let temp: Double
}

struct Weather: Codable {
  let id: Int
  let description: String
}

//struct List: Decodable {
//  let main: [Main]
//  let weather: [Weather]
//}

