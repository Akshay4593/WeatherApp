//
//  Date+Ext.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 08/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

extension String {
    
    var toDate: Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:self)
        return date
        
    }
    
    func getDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
        
    }
    
    func toDate(format: String = "MM/dd/yyyy hh:mm:ss a") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from: self)
        return date
    }
 
}

extension Date {
      
    var day : Int? {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        let day = components.day
        return day
        
    }
    
    var dayInWeek : String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let dayInWeek = dateFormatter.string(from: self)
        
        return dayInWeek
        
    }
}
