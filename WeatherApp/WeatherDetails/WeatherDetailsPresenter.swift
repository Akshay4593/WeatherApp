//
//  WeatherDetailsPresenter.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

class WeatherDetailsPresenter : WeatherDetailsPresenterProtocol {

    var view: WeatherDetailsVCProtocol?
    
    var interactor: WeatherDetailsInputInteractorProtocol?
    
    var wireFrame: WeatherDetailsWireFrameProtocol?
    
    var cityName: String? = ""
    
    init(city: String) {
        self.cityName = city
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        makeWeatherRequestWebCall()
    }
    
    private func makeWeatherRequestWebCall(){
        interactor?.makeWeatherRequest(cityName: cityName!)
    }
    
    private func makeForecastRequestWebCall(){
        interactor?.makeForecastRequest(cityName: cityName!)
    }
    
}

extension WeatherDetailsPresenter : WeatherDetailsOutputInteractorProtocol {
    func onSuccessWeatherRequest(response: WeatherResponse) {
        makeForecastRequestWebCall()
    }
    
    
}
