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
    
    func createWeatherDetailsModule(city: String) -> UIViewController {
        let vc = UIStoryboard(name: "Weather", bundle: nil)
            .instantiateViewController(withIdentifier: "WeatherDetailsVC") as! WeatherDetailsVC
        
        let presenter: WeatherDetailsPresenterProtocol & WeatherDetailsOutputInteractorProtocol = WeatherDetailsPresenter(city: city)
        let interactor: WeatherDetailsInputInteractorProtocol = WeatherDetailsInteractor()
        let wireFrame: WeatherDetailsWireFrameProtocol = WeatherDetailsWireframe()
        
        vc.presenter = presenter
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        
        return vc
    }
    
    func cityNameModule(city: String, delegate: CityNameProtocol?) -> UIViewController {
        let vc = UIStoryboard(name: "Weather", bundle: nil)
            .instantiateViewController(withIdentifier: "CityNameVC") as! CityNameVC
        vc.cityName = city
        vc.delegate = delegate
        return vc
    }
    
    func setRootVC() -> UIViewController {
        
        let flag = UserDefaults.standard.bool(forKey: Constant.USER_DEFAUL_KEY) ?? false
      
        if flag {
            guard let cityName = CoreDataManager.shared.fetchAllDailyData().first?.cityName else {
                return UIViewController()
            }
            return createWeatherDetailsModule(city: cityName)
            
        } else {
            
            return cityNameModule(city: "", delegate: nil)
        }
    }

    
}
