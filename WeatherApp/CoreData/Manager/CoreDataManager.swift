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
        request.returnsObjectsAsFaults = false
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [WeeklyData]()
    }
    
    public func fetchAllDailyData() -> [DailyData] {
        let request: NSFetchRequest<DailyData> = DailyData.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [DailyData]()
    }
    
    func insertWeeklyData(list:[WeatherResponse]) {
        for item in list {
            guard let weeklyData = NSEntityDescription.insertNewObject(forEntityName: "WeeklyData", into: backgroundContext) as? WeeklyData else { return }
            if let _date = item.date {
                weeklyData.dateInTimeStramp = _date
            }
            if let dayInWeek = item.dayInWeek {
                weeklyData.dayInWeek = dayInWeek
            }
            
            if let weatherData = item.weather?.first {
                weeklyData.imgUrl = weatherData.imageFullPath
            }
            
            if let mainData = item.main {
                weeklyData.minTemp = mainData.tempMin
                weeklyData.maxTemp = mainData.tempMax
            }
            
            allWeeklyData.append(weeklyData)
            save()
        }
    }
    
    func insertDailyData(data:WeatherResponse) {
        
        guard let dailyData = NSEntityDescription.insertNewObject(forEntityName: "DailyData", into: backgroundContext) as? DailyData else { return }
        
        
        if let mainData = data.main {
            dailyData.avgTemp = mainData.temp
            dailyData.minTemp = mainData.tempMin
            dailyData.maxTemp = mainData.tempMax
        }
        
        if let cityName = data.name {
            dailyData.cityName = cityName
        }
        
        if let weatherData = data.weather?.first {
            dailyData.imgUrl = weatherData.imageFullPath
            dailyData.desc = weatherData.description
        }
        allDailyData.append(dailyData)
        
        save()
    }
    
    
    func clearData(){
        
        deleteDailyData()
        deleteWeeklyData()
        
    }
    
    
    private func deleteDailyData(){
        let dailyDataFetchRequest: NSFetchRequest<DailyData> = DailyData.fetchRequest()
        if let results = try? persistentContainer.viewContext.fetch(dailyDataFetchRequest) {
            do {
                let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
                
                for object in results {
                    context.delete(object)
                }
                try? context.save()
            }
        }
        
        return
        
    }
    
    
    private func deleteWeeklyData(){
        let weeklyDataFetchRequest: NSFetchRequest<WeeklyData> = WeeklyData.fetchRequest()
        if let results = try? persistentContainer.viewContext.fetch(weeklyDataFetchRequest) {
            
            do {
                let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
                
                for object in results {
                    context.delete(object)
                }
                try? context.save()
            }
        }
        return
        
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

