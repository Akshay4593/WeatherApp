//
//  WeatherRoute.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

enum WeatherRoute {
    case weather
    case forecaste
}

extension WeatherRoute {
    
    private var baseUrl: String {
        return Constant.WEATHER_MAP_BASE_PATH
    }
    
    private var apiEndPoint: String {
        return "\(baseUrl)/\(version)/\(resource)?APPID=\(Constant.API_KEY)"
    }
    
    private var urlPath: String {
        switch self {
        case .weather:
            return "movie/popular"
        case .forecaste:
            return "search/movie"
        }
    }
    
    var url: URL {
        return URL(string: apiEndPoint)!
    }
    
    private var version: String {
        return "2.5"
    }
    
    private var resource: String {
        
        switch self {
        case .weather:
            return "weather"
        case .forecaste:
            return "forecast"

        }
    }
    
    var asRoute: Route {
        switch self {
        case .weather:
            return Route.getRoute(path: apiEndPoint)
        case .forecaste:
            return Route.getRoute(path: apiEndPoint)
        }
    }
    
}
