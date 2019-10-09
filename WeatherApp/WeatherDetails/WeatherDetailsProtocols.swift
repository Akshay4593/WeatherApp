//
//  WeatherDetailsProtocols.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

protocol WeatherDetailsWireFrameProtocol: class {
   
    func goToCityNameScreen(city: String, view: WeatherDetailsVCProtocol)
    
}

protocol WeatherDetailsVCProtocol  {
    var presenter: WeatherDetailsPresenterProtocol? { get set }
    
    func showCurrentDayData(response: WeatherResponse)
    
    func showForecastData(response: [WeatherResponse])
    
    
    
    //Show data from local database
    
    func showDailyData(dailyData: DailyData?)
    
    func showWeeklyData(weeklyData: [WeeklyData]?)
    
    
}

protocol WeatherDetailsPresenterProtocol : BasePresenter {
    var view: WeatherDetailsVCProtocol? { get set }
    var interactor: WeatherDetailsInputInteractorProtocol? { get set }
    var wireFrame: WeatherDetailsWireFrameProtocol? { get set }
    
    func showCityNameScreen(city: String)
    
}

protocol WeatherDetailsInputInteractorProtocol: class {
    var presenter: WeatherDetailsOutputInteractorProtocol? { get set }
    
    func makeWeatherRequest(cityName: String)
    func makeForecastRequest(cityName: String)
    
    
}

protocol WeatherDetailsOutputInteractorProtocol: class {
 
    func onSuccessWeatherRequest(response: WeatherResponse)
    func onSuccessForecastRequest(response: ForecastResponse)
    
}

@objc protocol BasePresenter: class {
    func viewDidLoad()
    func viewWillAppear()
    @objc optional func viewWillDisapper()
}
