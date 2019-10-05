//
//  CityNameVC.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit

class CityNameVC: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnAction(_ sender: UIButton) {
        
        guard let cityName = cityTextField.text else {
            return
        }
        let vc = AppNavigationCordinator.shared.createWeatherDetailsModule(city: cityName)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
