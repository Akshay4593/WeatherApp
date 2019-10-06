//
//  ForecastRequest.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 06/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

class ForecastResponse : Codable {
    
    
    var cod: String = ""
    var message: Double = 0
    var cnt: Double = 0
    var list: [WeatherResponse] = []
    var city: City?
  
    
    
    enum CodingKeys: String, CodingKey {
        
        case cod
        case message
        case cnt
        case list
        case city
      
    }
    
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try values.decode(String.self, forKey: .cod)
        message = try values.decode(Double.self, forKey: .message)
        cnt = try values.decode(Double.self, forKey: .cnt)
        list = try values.decode([WeatherResponse].self, forKey: .list)
        city = try values.decodeIfPresent(City.self, forKey: .city)
      
        
        
    }
    
    
}

class City : Codable {
    
    var id: Double = 0
    var name: String = ""
    var coord: Coordinates?
    var country: String?
    var population: Double?
    var timeZone: Double?
    var sunrise: Double?
    var sunset: Double?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case coord
        case country
        case population
        case timeZone
        case sunrise
        case sunset

    }
    
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Double.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        coord = try values.decodeIfPresent(Coordinates.self, forKey: .coord)
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        population = try values.decodeIfPresent(Double.self, forKey: .population) ?? 0
        timeZone = try values.decodeIfPresent(Double.self, forKey: .timeZone) ?? 0
        sunrise = try values.decodeIfPresent(Double.self, forKey: .sunrise) ?? 0
        sunset = try values.decodeIfPresent(Double.self, forKey: .sunset) ?? 0
        
    }
}


class ForecastRequest: APIRequest<ForecastResponse> {
    
    private var city: String = ""
    
    init(city: String) {
        super.init(route: WeatherRoute.forecaste.asRoute)
        self.city = city
    }
    
    override func getParameters() -> [String : Any] {
        return [
            "q": self.city
        ]
    }
    
}
