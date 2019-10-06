//
//  WeatherDetailsPresenter.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

enum ApiStatus {
    
    case none
    case started
    case error
    case success
}


class WeatherDetailsPresenter : WeatherDetailsPresenterProtocol {

    var view: WeatherDetailsVCProtocol?
    
    var interactor: WeatherDetailsInputInteractorProtocol?
    
    var wireFrame: WeatherDetailsWireFrameProtocol?
    
    var cityName: String? = ""
    
    private var weatherApiStatus: ApiStatus = .none
    private var forecastApiStatus: ApiStatus = .none
    
    init(city: String) {
        self.cityName = city
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        makeApiCalls()
    }
    
    private func makeApiCalls(){
        makeWeatherRequestWebCall()
        makeForecastRequestWebCall()
    }
    
    private func makeWeatherRequestWebCall(){
        weatherApiStatus = .started
        interactor?.makeWeatherRequest(cityName: cityName!)
    }
    
    private func makeForecastRequestWebCall(){
        forecastApiStatus = .started
        interactor?.makeForecastRequest(cityName: cityName!)
    }
    
}

extension WeatherDetailsPresenter : WeatherDetailsOutputInteractorProtocol {
    
    func onSuccessForecastRequest(response: ForecastResponse) {
        forecastApiStatus = .success
        
    }
    
    func onSuccessWeatherRequest(response: WeatherResponse) {
        weatherApiStatus = .success
    }
    
    
}
