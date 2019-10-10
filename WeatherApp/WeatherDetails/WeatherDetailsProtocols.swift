//
//  WeatherDetailsProtocols.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

protocol WeatherDetailsWireFrameProtocol: class {
    
    func goToCityNameScreen(city: String, view: WeatherDetailsVCProtocol, delegate: CityNameProtocol)
    
}

protocol WeatherDetailsVCProtocol  {
    var presenter: WeatherDetailsPresenterProtocol? { get set }
    
    func showCurrentDayData(response: WeatherResponse)
    
    func showForecastData(response: [WeatherResponse])
    
    
    
    //Show data from local database
    
    func showDailyData(dailyData: DailyData)
    
    func showWeeklyData(weeklyData: [WeeklyData])
    func showDataType(type: WheatherDetailsFor)
    
    func makeToast(msg: String)
    
    func showLoading()
    func hideLoading()
    
}

protocol WeatherDetailsPresenterProtocol : BasePresenter {
    var view: WeatherDetailsVCProtocol? { get set }
    var interactor: WeatherDetailsInputInteractorProtocol? { get set }
    var wireFrame: WeatherDetailsWireFrameProtocol? { get set }
    var cityName: String? { get set }
    
    func showCityNameScreen(city: String, delegate: CityNameProtocol)
    
}

protocol WeatherDetailsInputInteractorProtocol: class {
    var presenter: WeatherDetailsOutputInteractorProtocol? { get set }
    
    func makeWeatherRequest(cityName: String)
    func makeForecastRequest(cityName: String)
    
    
}

protocol WeatherDetailsOutputInteractorProtocol: class {
    
    func onSuccessWeatherRequest(response: WeatherResponse)
    func onSuccessForecastRequest(response: ForecastResponse)
    
    func onWeatherError(error: APIError)
    func onForecastError(error: APIError)
    
}

@objc protocol BasePresenter: class {
    func viewDidLoad()
    func viewWillAppear()
    @objc optional func viewWillDisapper()
}

