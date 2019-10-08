//
//  WeatherDetailsWireframe.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailsWireframe : WeatherDetailsWireFrameProtocol {
    
    
    func goToCityNameScreen(city: String, view: WeatherDetailsVCProtocol) {
        
        if let sourceVC = view as? UIViewController {
            let cityNameVC = AppNavigationCordinator.shared.cityNameModule()
            sourceVC.present(cityNameVC, animated: true, completion: nil)
        }
    }
    
    
    
}
