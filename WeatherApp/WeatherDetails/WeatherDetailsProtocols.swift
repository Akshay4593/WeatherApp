//
//  WeatherDetailsProtocols.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

protocol WeatherDetailsWireFrameProtocol: class {
   
    
}

protocol WeatherDetailsVCProtocol  {
    var presenter: WeatherDetailsPresenterProtocol? { get set }
    
}

protocol WeatherDetailsPresenterProtocol : BasePresenter {
    var view: WeatherDetailsVCProtocol? { get set }
    var interactor: WeatherDetailsInputInteractorProtocol? { get set }
    var wireFrame: WeatherDetailsWireFrameProtocol? { get set }
    
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
