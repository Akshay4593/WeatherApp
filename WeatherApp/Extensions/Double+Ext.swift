//
//  Double+Ext.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 09/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

extension Double {
    
    var inCelcius : Int {
        return Int((self - 273.15).rounded())
    }
}
