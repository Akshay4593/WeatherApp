//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Akshay Shedge on 09/10/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    private let persistentContainer: NSPersistentContainer!
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    private var allWeeklyData: [WeeklyData] = []
    
    private var allDailyData: [DailyData] = []


    
    static var shared: CoreDataManager = {
        return CoreDataManager()
    }()
    
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        configure()

    }
    
    private convenience init() {
        //Use the default container for production environment
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    
    private func configure() {
        //fetch all data
        allWeeklyData.append(contentsOf: fetchAllWeeklyData())
        allDailyData.append(contentsOf: fetchAllDailyData())
    }
    
    
    public func fetchAllWeeklyData() -> [WeeklyData] {
        let request: NSFetchRequest<WeeklyData> = WeeklyData.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [WeeklyData]()
    }
    
    public func fetchAllDailyData() -> [DailyData] {
        let request: NSFetchRequest<DailyData> = DailyData.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [DailyData]()
    }
    
    
    @discardableResult
    func insertWeeklyData(list:[WeatherResponse]) -> WeeklyData? {
        
        for item in list {
            
            guard let weeklyData = NSEntityDescription.insertNewObject(forEntityName: "WeeklyData", into: backgroundContext) as? WeeklyData else { return nil }
            
            weeklyData.dateInTimeStramp = item.date!
            allWeeklyData.append(weeklyData)
           
            save()
            return weeklyData
        }
        
        return nil
    }
    
    @discardableResult
    func insertDailyData(data:WeatherResponse) -> DailyData? {
        
           guard let dailyData = NSEntityDescription.insertNewObject(forEntityName: "DailyData", into: backgroundContext) as? DailyData else { return nil }
        
//        @NSManaged public var cityName: String?
//        @NSManaged public var avgTemp: Double
//        @NSManaged public var minTemp: Double
//        @NSManaged public var maxTemp: Double
//        @NSManaged public var desc: String?
//        @NSManaged public var imgUrl: String?
//        
//        
//        
//        
//        
//            dailyData.minTemp = data.main?.tempMin
//            allWeeklyData.append(weeklyData)
            
            save()
            return dailyData
        
    }
    
    
 
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
        
    }
    
    
    
}
