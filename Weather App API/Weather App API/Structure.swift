//
//  Structure.swift
//  Application Program Interface
//
//  Created by Taimoor Hassan on 04/04/2023.
//
import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone, id: Int?
    var name: String?
    var cod: Int?
    
   //MARK: get url
    func getAPIUrl(name :String) -> URL {
        let url = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=1fc49f27a2d283192d2c8c12c34731ee&q=\(name)"
        return URL(string: url)!
        
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    var lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    var type, id: Int?
    var country: String?
    var sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int?
    var main, description, icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}
