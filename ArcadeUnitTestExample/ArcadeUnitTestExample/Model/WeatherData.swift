//
//  WeatherData.swift
//  ArcadeUnitTestExample
//
//  Created by Running Raccoon on 2021/10/07.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
