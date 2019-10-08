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
    
    private var forecastResponse: ForecastResponse?
    private var weatherResponse: WeatherResponse?
    
    private var datesArray: [Int] = []
    private var requiredForecastList: [WeatherResponse]? = []
    
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
    
    private func showDataOnAllSuccess(){
        
        if forecastApiStatus == .success && weatherApiStatus == .success {
            if let currentDayData = weatherResponse,
                let weekData = requiredForecastList {
                view?.showCurrentDayData(response: currentDayData)
                view?.showForecastData(response: weekData)
            }
        }
    }
    
    
    private func operationOnList(){
        
        guard let list = forecastResponse?.list else {
            return
        }
        getRequiredForecastList(list: list)
 
        guard let reqForecastList = self.requiredForecastList else {
            print("No list")
            return
        }
        print("required .list===>> \(reqForecastList.count)")
        
    }
    
    private func getRequiredForecastList(list: [WeatherResponse]){
        
        list.forEach({
            let _date = $0.date ?? 0
            let date = Date(timeIntervalSince1970: _date)
            if let day = date.day,
                let currentDay = Date().day {
                if day != currentDay {
                    if !datesArray.contains(day){
                        datesArray.append(day)
                        self.requiredForecastList?.append($0)
                    }
                }
            }
        })
        
    }
    
}

extension WeatherDetailsPresenter : WeatherDetailsOutputInteractorProtocol {
    
    func onSuccessForecastRequest(response: ForecastResponse) {
        forecastApiStatus = .success
        forecastResponse = response
        operationOnList()
        showDataOnAllSuccess()
        
        
    }
    
    func onSuccessWeatherRequest(response: WeatherResponse) {
        weatherApiStatus = .success
        weatherResponse = response
        showDataOnAllSuccess()
    }
    
    
}
