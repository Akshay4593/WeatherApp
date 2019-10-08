//
//  WeeklyData+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 09/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//
//

import Foundation
import CoreData


extension WeeklyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeeklyData> {
        return NSFetchRequest<WeeklyData>(entityName: "WeeklyData")
    }

    @NSManaged public var dateInTimeStramp: Double
    @NSManaged public var dayInWeek: String?
    @NSManaged public var imgUrl: String?
    @NSManaged public var minTemp: Double
    @NSManaged public var maxTemp: Double

}
