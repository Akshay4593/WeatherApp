//
//  WeatherResponseModels.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 06/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

class Coordinates : Codable {
    
    var lon: Double?
    var lat: Double?
    
    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon) ?? -1
        lat = try values.decodeIfPresent(Double.self, forKey: .lat) ?? -1
    }
}

class Weather : Codable {
    
    
    var id: Int = -1
    var main: String = ""
    var description: String = ""
    var icon: String = ""
    
    var imageFullPath: String {
        return "\(Constant.WEATHER_MAP_IMAGE_BASE_PATH)/\(icon).png"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
    
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        main = try values.decode(String.self, forKey: .main)
        description = try values.decode(String.self, forKey: .description)
        icon = try values.decode(String.self, forKey: .icon)
        
    }
}

class Main : Codable {

    
    
    var temp: Double = 0
    var pressure: Double = 0
    var humidity: Double = 0
    var tempMin: Double = 0
    var tempMax: Double = 0
    var seaLevel: Double?
    var groundLevel: Double?
    var tempKF: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case tempKF = "temp_kf"
        
    }
    
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decode(Double.self, forKey: .temp)
        pressure = try values.decode(Double.self, forKey: .pressure)
        humidity = try values.decode(Double.self, forKey: .humidity)
        tempMax = try values.decode(Double.self, forKey: .tempMax)
        tempMin = try values.decode(Double.self, forKey: .tempMin)
        seaLevel = try values.decodeIfPresent(Double.self, forKey: .seaLevel) ?? 0
        groundLevel = try values.decodeIfPresent(Double.self, forKey: .groundLevel) ?? 0
        tempKF = try values.decodeIfPresent(Double.self, forKey: .tempKF) ?? 0
        
    }
}

class Wind : Codable {
    
    var speed: Double = 0
    var deg: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
    
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decode(Double.self, forKey: .speed)
        deg = try values.decode(Double.self, forKey: .deg)
    }
    
    
}

class Clouds : Codable {
    
    var all: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case all
        
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all = try values.decode(Int.self, forKey: .all)
    }
    
    
}

class Sys : Codable {
    
    var type: Int?
    var id: Double?
    var message: Double?
    var country: String?
    var sunrise: Double?
    var sunset: Double?
    var pod: String?
    
    enum CodingKeys: String, CodingKey {
        
        case type
        case id
        case message
        case country
        case sunrise
        case sunset
        case pod
    }
    
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(Int.self, forKey: .type) ?? -1
        id = try values.decodeIfPresent(Double.self, forKey: .id) ?? -1
        message = try values.decodeIfPresent(Double.self, forKey: .message) ?? 0
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        sunrise = try values.decodeIfPresent(Double.self, forKey: .sunrise) ?? 0
        sunset = try values.decodeIfPresent(Double.self, forKey: .sunset) ?? 0
        pod = try values.decodeIfPresent(String.self, forKey: .pod) ?? ""

    }
    
}

class Rain : Codable {
    
    var threeHours: Double?
    
    enum CodingKeys: String, CodingKey {
        case threeHours = "3h"
        
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        threeHours = try values.decodeIfPresent(Double.self, forKey: .threeHours) ?? 0
    }
    
    
}
