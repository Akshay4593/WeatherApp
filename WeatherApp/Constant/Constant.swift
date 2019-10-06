//
//  Constant.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

class Constant {
    private init() {}
    
    //Eg: http://openweathermap.org/img/w/10d.png
    
    //api.openweathermap.org/data/2.5/forecast?q=mumbai&APPID=1c7a1f1eb70508bcbf409f2f1e87a776
    
    static let WEATHER_MAP_BASE_PATH = "http://api.openweathermap.org/data"
    static let WEATHER_MAP_IMAGE_BASE_PATH = "http://openweathermap.org/img/w"
    static let API_KEY = "1c7a1f1eb70508bcbf409f2f1e87a776"
}
