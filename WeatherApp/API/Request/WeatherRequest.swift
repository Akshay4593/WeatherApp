//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

class WeatherResponse: Codable {
    

    var timezone: Double = 0
    var id: Int = 0
    var name: String = ""
    var cod: Double = 0
    var coord: Coordinates?
    var weather: [Weather]?
    var base: String = ""
    var main: Main?
    var visibility: Double = 0
    var wind: Wind?
    var clouds: Clouds?
    var date: Double = -1
    var sys: Sys?
    
    enum CodingKeys: String, CodingKey {
        
        case timezone
        case id
        case name
        case cod
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case sys
        case date = "dte"
    }
    
}

class Coordinates : Codable {
    
    var lon: Double
    var lat: Double
    
    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
}

class Weather : Codable {
    
    
    var id: Int = -1
    var main: String = ""
    var description: String = ""
    var icon: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
}

class Main : Codable {

    var temp: Double = 0
    var pressure: Double = 0
    var humidity: Double = 0
    var tempMin: Double = 0
    var tempMax: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        
    }
}

class Wind : Codable {
    
    var speed: Double = 0
    var deg: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
    
    
}

class Clouds : Codable {
    
    var all: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case all
        
    }
    
}

class Sys : Codable {
   
    
    var type: Int = 0
    var id: Double = 0
    var message: Double = 0
    var country: String = ""
    var sunrise: Double = 0
    var sunset: Double = 0
    
    enum CodingKeys: String, CodingKey {
        
        case type
        case id
        case message
        case country
        case sunrise
        case sunset
    }
    
}

class WeatherRequest: APIRequest<WeatherResponse> {
    
    private var city: String = ""
    
    init(city: String) {
        super.init(route: WeatherRoute.weather.asRoute)
        self.city = city
    }
    
    override func getParameters() -> [String : Any] {
        return [
            "q": self.city
        ]
    }
    
}
