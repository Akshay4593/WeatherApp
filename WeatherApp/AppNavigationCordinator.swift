//
//  AppNavigationCordinator.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//


import Foundation
import UIKit

class AppNavigationCordinator {
    
    static let shared: AppNavigationCordinator = AppNavigationCordinator()
    
    private init() {}
    
    func createWeatherDetailsModule() -> UIViewController {
        let vc = UIStoryboard(name: "Weather", bundle: nil)
            .instantiateViewController(withIdentifier: "WeatherDetailsVC") as! WeatherDetailsVC
        
        var presenter: WeatherDetailsPresenterProtocol & WeatherDetailsOutputInteractorProtocol = WeatherDetailsPresenter()
        var interactor: WeatherDetailsInputInteractorProtocol = WeatherDetailsInteractor()
        var wireFrame: WeatherDetailsWireFrameProtocol = WeatherDetailsWireframe()
        
        vc.presenter = presenter
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        
        return vc
    }
    

    
}
