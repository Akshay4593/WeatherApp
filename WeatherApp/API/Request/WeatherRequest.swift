//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

class WeatherResponse: Codable {
    
    
    var timezone: Double?
    var id: Int?
    var name: String?
    var cod: Double?
    var coord: Coordinates?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Double?
    var wind: Wind?
    var clouds: Clouds?
    var date: Double?
    var sys: Sys?
    var rain: Rain?
    var dateText: String?
    
   
    
    var dateInInt: Int? {
      
        if let _date = date {
            let dateInDateFormat = Date(timeIntervalSince1970: _date)
            let day = dateInDateFormat.day
            return day
        }
       
        return nil
        
    }
    
    var dayInWeek: String? {
        
        if let _date = date {
            let dateInDateFormat = Date(timeIntervalSince1970: _date)
            let dayInWeek = dateInDateFormat.dayInWeek
            return dayInWeek
        }
        
        return nil
    }
    
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
        case date = "dt"
        case sys
        case rain
        case dateText = "dt_txt"
    }
    
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        timezone = try values.decodeIfPresent(Double.self, forKey: .timezone) ?? 0
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        cod = try values.decodeIfPresent(Double.self, forKey: .cod) ?? 0
        coord = try values.decodeIfPresent(Coordinates.self, forKey: .coord)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        base = try values.decodeIfPresent(String.self, forKey: .base) ?? ""
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        visibility = try values.decodeIfPresent(Double.self, forKey: .visibility) ?? 0
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        date = try values.decodeIfPresent(Double.self, forKey: .date) ?? -1
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        rain = try values.decodeIfPresent(Rain.self, forKey: .rain)
        dateText = try values.decodeIfPresent(String.self, forKey: .dateText) ?? ""


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
