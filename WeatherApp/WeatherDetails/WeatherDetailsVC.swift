//
//  WeatherDetailsVC.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 05/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import UIKit

class WeatherDetailsVC: UIViewController {
    
    var presenter: WeatherDetailsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension WeatherDetailsVC : WeatherDetailsVCProtocol {
    
    
}
