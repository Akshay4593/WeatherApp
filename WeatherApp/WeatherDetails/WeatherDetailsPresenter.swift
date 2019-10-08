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
    
    weak var timer: Timer?

    
    init(city: String) {
        self.cityName = city
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        makeApiCalls()
    }
    
    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true) { [weak self] _ in
            // do something here
            self?.makeApiCalls()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    // if appropriate, make sure to stop your timer in `deinit`
    
    deinit {
        stopTimer()
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
                setFlagInUserDefault(flag: true)
                view?.showCurrentDayData(response: currentDayData)
                view?.showForecastData(response: weekData)
                stopTimer()
                startTimer()

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
            if let day = $0.dateInInt,
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
    
    
    func setFlagInUserDefault(flag: Bool){
        UserDefaults.standard.set(flag, forKey: Constant.USER_DEFAUL_KEY)
    }
    
    func showCityNameScreen(city: String) {
        
        wireFrame?.goToCityNameScreen(city: city, view: view!)
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


