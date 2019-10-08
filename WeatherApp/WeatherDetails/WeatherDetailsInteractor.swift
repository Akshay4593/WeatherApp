//
//  WeatherDetailsInteractor.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

class WeatherDetailsInteractor : WeatherDetailsInputInteractorProtocol {

    var presenter: WeatherDetailsOutputInteractorProtocol?
    
    func makeWeatherRequest(cityName: String) {
       WeatherRequest(city: cityName).response { [weak self] (result) in
            switch result {
            case .success(let response):
                print("Success weather")
                self?.presenter?.onSuccessWeatherRequest(response: response)
                break
            case .failure(let error):
                print("failure===>> \(error)")

                break
            }
        }
    }
    
    func makeForecastRequest(cityName: String) {
        ForecastRequest(city: cityName).response{ [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.onSuccessForecastRequest(response: response)
                print("Success forecast")
                break
            case .failure(let error):
                print("failure===>> \(error)")
                
                break
            }
        }
    }
    

    
    
}

